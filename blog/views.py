from django.shortcuts import render, redirect
from .models import Item
from redis import Redis
import os
import logging

redis = Redis(host=os.environ['REDIS_PORT_6379_TCP_ADDR'],
              port=os.environ['REDIS_PORT_6379_TCP_PORT'],
              password=os.environ.get('REDIS_PASSWORD'))

#log
logger = logging.getLogger(__name__)

def home(request):
    if request.method == 'POST':
        Item.objects.create(text=request.POST['item_text'])
        return redirect('/')
    items = Item.objects.all()
    counter = redis.incr('counter')
    logger.info(counter)
    return render(request, 'home.html', {'items': items, 'counter': counter})
