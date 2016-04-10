"""
Definition of views.
"""

from os import path
from datetime import datetime
import random

from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpRequest, HttpResponseRedirect
from django.shortcuts import get_object_or_404, get_list_or_404, render
from django.template import RequestContext
from django.utils import timezone
from django.views.generic import ListView, DetailView
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.utils.translation import ugettext_lazy as _
from django.db.models.functions import Lower

from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Fieldset, ButtonHolder, Submit, ButtonHolder, Div, Field, HTML
from crispy_forms.bootstrap import InlineCheckboxes
from crispy_forms.utils import render_crispy_form

from X.models import *
from X.forms import NoteForm
from X.views import g_tab_list
from X.views import Q
from X.common import *

from .tags import FormSymbol, appointment_tag_list, handleTagRequest, getTagRequestList

###############################################################################

class AppointmentForm(forms.ModelForm):
    """Edit form for Appointment model"""
    class Meta:
        model = Appointment
        fields = [
            'tag1',
            'tag2',
            'tag3',
            'tag4',
            'tag5',
            'tag6',
            'tag7',
            'tag8',
            'tag9',
            'tag10',
            'tag11',
            'name',
            'description',
            ]

    def __init__(self, *args, **kwargs):
        super(AppointmentForm, self).__init__(*args, **kwargs)

        self.helper = FormHelper()
        self.helper.form_class = 'blueForms'
        self.helper.form_class = 'form-horizontal'
        self.helper.label_class = 'col-sm-2'
        self.helper.field_class = 'col-sm-10'
        self.helper.form_tag = False
        self.helper.layout = Layout(

            Div(
                Div(FormSymbol(appointment_tag_list[1]['img']),  Field('tag1'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[2]['img']),  Field('tag2'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[3]['img']),  Field('tag3'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[4]['img']),  Field('tag4'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[5]['img']),  Field('tag5'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[6]['img']),  Field('tag6'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[7]['img']),  Field('tag7'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[8]['img']),  Field('tag8'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[9]['img']),  Field('tag9'),  style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[10]['img']), Field('tag10'), style="padding:0; margin:0;", css_class='checkbox-inline'),
                Div(FormSymbol(appointment_tag_list[11]['img']), Field('tag11'), style="padding:0; margin:0;", css_class='checkbox-inline'),
                css_class='col-sm-offset-2', style="margin-top:0px;", 
                ),

            Field('name', style="width:30em; min-width:30em; max-width:100%; "),

            #Field('progress', template="X/tmpl_slider_progress.html"),

            Field('description', style="max-width:100%; min-width:100%;", rows=10),
            )

    def clean_name(self):
      name = self.cleaned_data.get('name')
      return name

###############################################################################

@login_required
def scheduler(request, appointment_id):
    """Handles page requests for Appointments"""

    env = Env(request)


    tag_list = getTagRequestList(request, 'appointment')

    #appointments = get_list_or_404(Appointment)
    
    try:
        selected_appointment = Appointment.objects.get(pk = appointment_id)
        selected_note = selected_appointment.note
    except ObjectDoesNotExist:
        selected_appointment = None
        selected_note = None

    ### create new appointment object on request '/appointment/0'
    if appointment_id == '0':
        selected_appointment = Appointment(project=env.project);

    ### handle buttons
    if request.method == 'POST':
        if not selected_appointment:   # you shall not pass ... without valid scope
            raise AssertionError 

        # generate forms and/or get data out of the edited forms
        formNote = NoteForm(request.POST or None, instance=selected_note)
        if formNote.is_valid():
            selected_note = formNote.instance
        formItem = AppointmentForm(request.POST or None, instance=selected_appointment)
        if formItem.is_valid():
            selected_appointment = formItem.instance

        # 'Delete'-Button
        if request.POST.get('btn_delete'):
            if selected_note:
                if selected_note.id:
                    selected_note.delete()
            selected_appointment.note = None
            selected_appointment.delete()
            return HttpResponseRedirect('/scheduler/')

        # 'Add Note'-Button
        if request.POST.get('btn_note'):
            selected_note = Note(project=env.project, author=env.user )
            selected_appointment.note = selected_note
            #formNote = NoteForm(request.POST or None, instance=selected_note) #JK may be re-connect to form???

        # 'Save'-Button
        if request.POST.get('btn_save'):
            if selected_note:
                if selected_note.text=='':
                    if selected_note.id:
                        selected_note.delete()
                    selected_note = None
                else:
                    selected_note.save()

            selected_appointment.note = selected_note

            if selected_appointment:
                if formItem.is_valid():
                    formItem.save()
                #selected_appointment.save()

            if appointment_id == '0':   # previously new item
                return HttpResponseRedirect('/scheduler/' + str(selected_appointment.id))
    else:
        formItem = AppointmentForm(instance=selected_appointment)
        formNote = NoteForm(instance=selected_note)
    
    ### conglomerate queries
    query = Q()
    for tag in tag_list:
        if tag['active']:
            if len(query)==0:
                query = g_tag_queries[tag['idx']]
            else:
                query |= g_tag_queries[tag['idx']]

    if len(query)==len(tag_list):
        query = Q()
    elif len(query)==0:
        query = g_tag_query_none
    
    appointments = Appointment.objects.filter( project=env.project_id ).filter( query ).order_by(Lower('name'))

    return render(request, 'X/scheduler.html', {
        'title': 'Appointment',
        'env': env,
        'tab_list': g_tab_list,
        'tab_active_id': 'T',
        'tag_list': tag_list,
        'appointments': appointments,
        'selected_appointment': selected_appointment,
        'form': formItem,
        'formNote': formNote,
        #'error_message': "Please make a selection.",
    })

###############################################################################

@login_required
def schedulerTag(request, tag_id):

    handleTagRequest(request, tag_id, 'appointment')

    return appointment(request, None)

###############################################################################
