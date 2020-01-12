from flask import Flask, request
import sys
from itertools import cycle
app = Flask(__name__)

@app.route('/rut/<rut>')
def hello_world(rut):
  rut = rut.upper()
  rut = rut.replace("-","")
  rut = rut.replace(".","")
  aux = rut[:-1]
  dv = rut[-1:]

  revertido = map(int, reversed(str(aux)))
  factors = cycle(range(2,8))
  s = sum(d * f for d, f in zip(revertido,factors))
  res = (-s)%11

  if str(res) == dv:
    return { "valido": True }
  elif dv=="K" and res==10:
    return { "valido": True }
  else:
    return { "No valido": False }

@app.route('/nombrePropio', methods=['POST'])
def nombrePropio():
  content = request.get_json()
  aPaterno = request.form['aPaterno']
  aMaterno = request.form['aMaterno']
  nombres = request.form['nombres']
  genero = request.form['genero']

  prefijo = "Sra. " if(genero == "F" or genero == "f") else "Sr. "
  fullName = prefijo + nombres + " " + aPaterno + " " + aMaterno
  return { "nombrePropio": fullName.title() }
