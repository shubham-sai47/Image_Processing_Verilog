#!/usr/bin/env python
# coding: utf-8

# ## Python code for converting image to text and text to image

# In[44]:


from skimage import io, color
from skimage import exposure
from skimage.util import *
from skimage.measure import compare_psnr, compare_ssim
import numpy as np
import matplotlib.pyplot as plt
import skimage.transform


# ## 1. Image to Text

# In[45]:


imgcam = io.imread('cameraman512.jpg')    # Load the image
imgcam = img_as_ubyte(color.rgb2gray(imgcam))
x = img_as_ubyte(skimage.transform.resize(imgcam, (128, 128)))
plt.imshow(x, cmap=plt.cm.gray)


# In[46]:


r = x.T.flatten()
np.savetxt('images.txt', r, delimiter='\n', fmt='%i')


# ## 2. Text to Image

# In[48]:


img = np.loadtxt('images.txt')
img = img.reshape((128,128),order='F')
plt.imshow(img, cmap=plt.cm.gray)


# In[ ]:




