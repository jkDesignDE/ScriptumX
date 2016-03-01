﻿"""
Definition of views.
"""

from app.models import *
from datetime import datetime
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpRequest, HttpResponseRedirect
from django.shortcuts import get_object_or_404, get_list_or_404, render
from django.template import RequestContext
from django.utils import timezone
from django.views.generic import ListView, DetailView
from os import path
from django.core.exceptions import ObjectDoesNotExist
from app.forms import GadgetForm
from crispy_forms.utils import render_crispy_form
from .tags import gadget_tag_list, handleTagRequest, getTagRequestList
from django.db.models import Q

import json
from app.views import Q

g_tag_queries = [ 
    Q(tag0=True), 
    Q(tag1=True), 
    Q(tag2=True), 
    Q(tag3=True), 
    Q(tag4=True), 
    Q(tag5=True), 
    Q(tag6=True), 
    Q(tag7=True), 
    Q(tag8=True), 
    Q(tag9=True), 
    Q(tag10=True), 
    Q(tag11=True), 
    ]

g_tag_query_none = Q(tag0=False) & Q(tag1=False) & Q(tag2=False) & Q(tag3=False) & Q(tag4=False) & Q(tag5=False) & Q(tag6=False) & Q(tag7=False) & Q(tag8=False) & Q(tag9=False) & Q(tag10=False) & Q(tag11=False)




def home(request):
    """Handles home page"""
    
    return render(request, 'app/home.html', {
        'title': 'Home',
        'datetime': datetime.now(),
    })


class PollListView(ListView):
    """Renders the home page, with a list of all polls."""
    model = Poll

    def get_context_data(self, **kwargs):
        context = super(PollListView, self).get_context_data(**kwargs)
        context['title'] = 'Polls'
        context['year'] = datetime.now().year
        return context

class PollDetailView(DetailView):
    """Renders the poll details page."""
    model = Poll

    def get_context_data(self, **kwargs):
        context = super(PollDetailView, self).get_context_data(**kwargs)
        context['title'] = 'Poll'
        context['year'] = datetime.now().year
        return context

class PollResultsView(DetailView):
    """Renders the results page."""
    model = Poll

    def get_context_data(self, **kwargs):
        context = super(PollResultsView, self).get_context_data(**kwargs)
        context['title'] = 'Results'
        context['year'] = datetime.now().year
        return context

def contact(request):
    """Renders the contact page."""
    assert isinstance(request, HttpRequest)
    return render(
        request,
        'app/contact.html',
        context_instance = RequestContext(request,
        {
            'title': 'Contact',
            'message': 'Your contact page.',
            'year': datetime.now().year,
        })
    )

def about(request):
    """Renders the about page."""
    assert isinstance(request, HttpRequest)
    return render(
        request,
        'app/about.html',
        context_instance = RequestContext(request,
        {
            'title': 'About',
            'message': 'Your application description page.',
            'year': datetime.now().year,
        })
    )

def vote(request, poll_id):
    """Handles voting. Validates input and updates the repository."""
    poll = get_object_or_404(Poll, pk=poll_id)
    try:
        selected_choice = poll.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        return render(request, 'app/details.html', {
            'title': 'Poll',
            'year': datetime.now().year,
            'poll': poll,
            'error_message': "Please make a selection.",
    })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        return HttpResponseRedirect(reverse('app:results', args=(poll.id,)))

import random
import string
def random_text(letters=32):
    return ''.join([random.choice(string.ascii_letters + string.digits + "     ") for n in range(letters)])


@login_required
def seed(request):
    """Seeds the database with sample polls."""
    samples_path = path.join(path.dirname(__file__), 'samples.json')
    with open(samples_path, 'r') as samples_file:
        samples_polls = json.load(samples_file)

    for sample_poll in samples_polls:
        poll = Poll()
        poll.text = sample_poll['text']
        poll.pub_date = timezone.now()
        poll.save()

        for sample_choice in sample_poll['choices']:
            choice = Choice()
            choice.poll = poll
            choice.text = sample_choice
            choice.votes = 0
            choice.save()

    # generate Gadgets
    for i in range(0, 10):
        gadget = Gadget()
        gadget.name = "Gadget-" + str(i)
        gadget.description = random_text()
        gadget.progress = i
        gadget.save()

    
    # generate SceneItem with linked Scenes
    for s in range(0, 5):
        scene = Scene()
        scene.name = "Scene-" + str(s)
        gadget.description = random_text()
        gadget.progress = i
        scene.save()

        for s in range(0, 5):
            item = SceneItem()
            item.text = random_text(300)
            item.scene = scene
            item.save()

    

    return HttpResponseRedirect(reverse('app:home'))



#def get_or_none(classmodel, **kwargs):
#    try:
#        return classmodel.objects.get(**kwargs)
#    except classmodel.DoesNotExist:
#        return None

tab_list = (
    { 'id':'P', 'name':'Project',  'href':'/project',  'img':'app/img/Tab/Project-16.png' },
    { 'id':'C', 'name':'Script',   'href':'/script',   'img':'app/img/Tab/Script-16.png' },
    { 'id':'S', 'name':'Scene',    'href':'/scene',    'img':'app/img/Tab/Scene-16.png' },
    { 'id':'L', 'name':'Set',      'href':'/set',      'img':'app/img/Tab/Set-16.png' },
    { 'id':'R', 'name':'Role',     'href':'/role',     'img':'app/img/Tab/Role-16.png' },
    { 'id':'F', 'name':'Folk',     'href':'/folk',     'img':'app/img/Tab/Folk-16.png' },
    { 'id':'G', 'name':'Gadget',   'href':'/gadget',   'img':'app/img/Tab/Gadget-16.png' },
    { 'id':'X', 'name':'SFX',      'href':'/sfx',      'img':'app/img/Tab/SFX-16.png' },
    { 'id':'A', 'name':'Audio',    'href':'/audio',    'img':'app/img/Tab/Audio-16.png' },
    { 'id':'T', 'name':'Schedule', 'href':'/schedule', 'img':'app/img/Tab/Schedule-16.png' },
    )


def gadget(request, gadget_id):
    """Handles page requests for Gadgets"""
    
    tag_list = getTagRequestList(request, 'gadget')

    #gadgets = get_list_or_404(Gadget)
    
    try:
        active_gadget = Gadget.objects.get(pk = gadget_id)
        active_id = active_gadget.id
    except ObjectDoesNotExist:
        active_gadget = None
        active_id = None


    if request.method == 'POST':
        form = GadgetForm(request.POST or None, instance=active_gadget)

        if form.is_valid():
            form.save()
            #gadgets = get_list_or_404(Gadget)
    else:
        form = GadgetForm(instance=active_gadget)
    
    query = Q()
    for tag in tag_list:
        if tag['active']:
            if len(query)==0:
                query = g_tag_queries[tag['bit']]
            else:
                query |= g_tag_queries[tag['bit']]

    if len(query)==len(tag_list):
        query = Q()
    elif len(query)==0:
        query = g_tag_query_none
    
    gadgets = Gadget.objects.filter( query )

    return render(request, 'app/gadget.html', {
        'title': 'Gadget',
        'tab_list': tab_list,
        'tab_active_id': 'G',
        'tag_list': tag_list,
        'gadgets': gadgets,
        'active_gadget': active_gadget,
        'active_id': active_id,
        'form': form,
        'datetime': datetime.now(),
        #'error_message': "Please make a selection.",
    })


def gadgetTag(request, tag_id):

    handleTagRequest(request, tag_id, 'gadget')

    return gadget(request, None)





def dummy(request, id):
    """Handles ..."""
    
    return render(request, 'app/gadget.html', {
        'title': 'DUMMY',
        'tab_list': tab_list,
        'tab_active_id': 'P',
        'datetime': datetime.now(),
    })



#To make things easier, here is a snippet of the code I wrote, based on inputs from the wonderful replies here:

#class MyManager(models.Manager):

#    def get_or_none(self, **kwargs):
#        try:
#            return self.get(**kwargs)
#        except ObjectDoesNotExist:
#            return None

#And then in your model:

#class MyModel(models.Model):
#    objects = MyManager()

#That's it. Now you have MyModel.objects.get() as well as MyModel.objetcs.get_or_none()
#shareimprove this answer
	
#answered Jul 22 '14 at 13:05
#Moti Radomski
#656
	
#1
	
#also, don't forget to import: from django.core.exceptions import ObjectDoesNotExist – Moti Radomski Jul 22 '14 at 13:07 
