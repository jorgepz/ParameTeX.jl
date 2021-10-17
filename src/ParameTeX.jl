module ParameTeX

using CSV
using DataFrames

function readParamFile( fileName )
  return DataFrame( CSV.File( fileName ) );
end

function generatePdfs( df , folder, baseTeX )
    dfheaders = names( df );
    rows = eachrow( df )
    numCols = length( dfheaders )
    paramsFile = joinpath( folder, "parameters.tex" )

    currFolder = pwd()

    print(" Starts row by row generation...\n")
    for row in rows

        # open file of parameters and write values
        paramsFileFid = open( paramsFile , "w" )
        for col in 1:numCols
            if typeof(row[col]) == String63
                valueAsString = replace( row[col], "&"=>"\\&")

            elseif typeof(row[col]) == Int64
                valueAsString = string( row[col] )
            else
                error("type not implemented yet, create and issue!")
            end
            write( paramsFileFid, "\\newcommand{\\" * dfheaders[col] * "}{" * valueAsString * "}\n")
        end
        close( paramsFileFid );

        # compile pdf
        fileExtension = baseTeX[end-3:end]
        fileName      = baseTeX[1:end-4]
        outputPdfFilename = fileName * "_" * replace( row[1]," "=>"_" ) * ".pdf"
        cd(folder)
        print(outputPdfFilename,"\n")
        run(`pdflatex $baseTeX`)
        run(`mv $fileName.pdf $outputPdfFilename`)
        cd(currFolder)
    end

end

export readParamFile
export generatePdfs

end # module
