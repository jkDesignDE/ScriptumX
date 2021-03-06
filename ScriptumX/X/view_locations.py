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

from .tags import FormSymbol, location_tag_list, handleTagRequest, getTagRequestList

###############################################################################

class LocationForm(forms.ModelForm):
    """Edit form for Location model"""
    class Meta:
        model = Location
        fields = [
            'tag1',
            'tag2',
            'tag3',
            'tag4',
            'tag5',
            'name',
            'abstract',
            'description',
            'persons',
            'gadgets',
            'costs',
            ]

    def __init__(self, *args, **kwargs):
        #super(LocationForm, self).__init__(*args, **kwargs)
        super().__init__(*args, **kwargs)

        self.helper = FormHelper()
        self.helper.form_class = 'blueForms'
        self.helper.form_class = 'form-horizontal'
        self.helper.label_class = 'col-sm-2'
        self.helper.field_class = 'col-sm-10'
        self.helper.form_tag = False
        self.helper.layout = Layout(

            Div(
                Div(FormSymbol(location_tag_list[1]['img']),  Field('tag1'),  title=location_tag_list[1]['name'], css_class='checkbox-inline checkbox-tags'),
                Div(FormSymbol(location_tag_list[2]['img']),  Field('tag2'),  title=location_tag_list[2]['name'], css_class='checkbox-inline checkbox-tags'),
                Div(FormSymbol(location_tag_list[3]['img']),  Field('tag3'),  title=location_tag_list[3]['name'], css_class='checkbox-inline checkbox-tags'),
                Div(FormSymbol(location_tag_list[4]['img']),  Field('tag4'),  title=location_tag_list[4]['name'], css_class='checkbox-inline checkbox-tags'),
                Div(FormSymbol(location_tag_list[5]['img']),  Field('tag5'),  title=location_tag_list[5]['name'], css_class='checkbox-inline checkbox-tags'),
                css_class='col-sm-offset-2 checkbox-tags-group', 
                ),

            Field('name'),
            Field('abstract', rows=1),

            Field('persons', css_class='chosen-select-multi'),
            Field('gadgets', css_class='chosen-select-multi'),

            Field('description', rows=12),

            Field('costs'),
            )

        for field_name in self.fields:
            if field_name[:3] == 'tag':
                field = self.fields.get(field_name)
                field.label = ''


    def clean_name(self):
      name = self.cleaned_data.get('name')
      return name

###############################################################################

@login_required
def location(request, location_id):
    """Handles page requests for Locations"""

    env = Env(request)


    tag_list = getTagRequestList(request, 'location')

    #locations = get_list_or_404(Location)
    
    try:
        selected_location = Location.objects.get(pk = location_id)
        selected_note = selected_location.note
    except ObjectDoesNotExist:
        selected_location = None
        selected_note = None

    ### create new location object on request '/location/0'
    if location_id == '0':
        selected_location = Location(project=env.project);

    ### handle buttons
    if request.method == 'POST':
        if not selected_location:   # you shall not pass ... without valid scope
            raise AssertionError 

        # generate forms and/or get data out of the edited forms
        formNote = NoteForm(request.POST or None, instance=selected_note)
        if formNote.is_valid():
            selected_note = formNote.instance
        formItem = LocationForm(request.POST or None, instance=selected_location)
        if formItem.is_valid():
            selected_location = formItem.instance

        # 'Delete'-Button
        if request.POST.get('btn_delete'):
            if selected_note:
                if selected_note.id:
                    selected_note.delete()
            selected_location.note = None
            selected_location.delete()
            return HttpResponseRedirect('/location/')

        # 'Add Note'-Button
        if request.POST.get('btn_note'):
            selected_note = Note(project=env.project, author=env.user )
            selected_location.note = selected_note
            #formNote = NoteForm(request.POST or None, instance=selected_note) #JK may be re-connect to form???

        # 'Save'-Button
        if request.POST.get('btn_save'):
            if selected_note:
                if selected_note.text=='':
                    if selected_note.id:
                        selected_note.delete()
                    selected_note = None
                else:
                    selected_note.project=env.project
                    selected_note.author=env.user
                    selected_note.save()

            selected_location.note = selected_note

            if selected_location:
                if formItem.is_valid():
                    formItem.save()
                #selected_location.save()

            if location_id == '0':   # previously new item
                return HttpResponseRedirect('/location/' + str(selected_location.id))
    else:
        formItem = LocationForm(instance=selected_location)
        formNote = NoteForm(instance=selected_note)

    formItem.fields['persons'].queryset = Person.objects.filter(project=env.project)
    formItem.fields['gadgets'].queryset = Gadget.objects.filter(project=env.project)

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
    
    locations = Location.objects.filter( project=env.project_id ).filter( query ).order_by(Lower('name'))

    return render(request, 'X/locations.html', {
        'title': 'Location',
        'env': env,
        'tab_list': g_tab_list,
        'tab_active_id': 'L',
        'tag_list': tag_list,
        'locations': locations,
        'selected_location': selected_location,
        'form': formItem,
        'formNote': formNote,
        #'error_message': "Please make a selection.",
    })

###############################################################################

@login_required
def locationTag(request, tag_id):

    handleTagRequest(request, tag_id, 'location')

    return location(request, None)

###############################################################################
