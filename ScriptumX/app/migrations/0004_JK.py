# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-03-01 14:52
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0003_JK'),
    ]

    operations = [
        migrations.AlterField(
            model_name='appointment',
            name='scenes',
            field=models.ManyToManyField(blank=True, through='app.Appointment2Scene', to='app.Scene'),
        ),
    ]