require "sketchup.rb"
path=Sketchup.find_support_file("Plugins")
Sketchup::require path+'/rexml/document'
#include REXML

def readxml
  xmlfilename = UI.openpanel "Load projector XML", "c:\\", "*.xml"
  file = File.new(xmlfilename)
  doc = Document.new(file)
  puts doc
end

def projectormaker
    draw_frustum
end

filename='projectormaker.rb'
if !file_loaded?(filename)
  UI.menu("PlugIns").add_item("Import projector") {
    projectormaker
  }
  file_loaded(filename)
end

def WD500UST()
  projector.ar = 16.0 / 10.0
  projector.throwratio=0.56
  projector.lensshift=0.574
  return projector
end

def XD500UST()
  projector.ar = 4.0 / 3.0
  projector.throwratio=0.7
  projector.lensshift=0.77
  return projector
end

def VSPH70()
  projector.ar = 4.0 / 3.0
  projector.throwratio=0.77
  projector.lensshift=0
end

def FL6500UwOLX500FR
  projector.ar = 4.0 / 3.0
  projector.throwratio=0.8
  projector.lensshift=0
end

def EW520()
  projector.ar = 4.0 / 3.0
  projector.throwratio=2.0
  projector.lensshift=0.64
end

def XD1270D_long()
  projector.ar = 4.0 / 3.0
  projector.throwratio=2.102
  projector.lensshift=0.6 #approx
end

def XD1270D_wide()
  projector.ar = 4.0 / 3.0
  projector.throwratio=1.9359
  projector.lensshift=0.6 #approx
end

def boring_projector()
  projector.ar = 1280.0 / 768.0;
  projector.throwratio = 1.6;
  projector.lensshift=0.6;
end

def draw_frustum
  
  ar = 4.0 / 3.0;
  throwratio = 1.4925;
  lensshift=0.32;
  
  
  # Create frustum variables
  distance = MtoI(1.0)
  width = distance / throwratio
  height = width / ar
  
  print "width: " , width, "\nheight: ", height, "\nar: ", ar, "\n"
  
  # Get handles to our model and the Entities collection it contains.
  model = Sketchup.active_model
  entities = model.entities

  # Calculate points
  # convergence point
  cp = [0, 0, 0]
  # corners
  tl = [distance, -width/2, height*(lensshift+0.5)]
  tr = [distance, width/2, height*(lensshift+0.5)]  
  bl = [distance, -width/2, height*(lensshift-0.5)]
  br = [distance, width/2, height*(lensshift-0.5)]
  
  # Make faces
  new_face = entities.add_face tl, tr, br, bl

  new_face = entities.add_face tl, tr, cp
  new_face = entities.add_face tl, bl, cp
  new_face = entities.add_face tr, br, cp
  new_face = entities.add_face bl, br, cp

end

def MtoI(inches)
  return inches*39.3700787
end