module ParameTeX

using CSV
using DataFrames

function readParamFile( fileName )
  return DataFrame( CSV.File( fileName ) );
end

function generatePdfs( df , folder, baseTeX )
    dfheaders = names(A);
    f = open( "../gestion/modeloComprobanteAsistencia/parameters.tex","w") # do this once
    rows = eachrow(A)
    cols = eachcol(A)

    print(rows)

    print(cols)
    for row in rows
        for col in cols
            print( "\\newcommand{\\" * dfheaders[col] * "}{" * row[col] * "}\n")
        end
    end
    close(f);
end

export readParamFile
export generatePdfs

end # module
