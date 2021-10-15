module ParameTeX

using CSV

greet() = print("Hello World!")

function readMyParamFile( fileName )
  data = CSV.read( fileName )
  return data
end

export readParamFile

end # module
