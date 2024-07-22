#! /bin/bash


## VARIABLES
## =========

cleanup=0
update=0
build=0


## USAGE FUNCTION
## ==============

function usage {
    echo " "
    echo "usage: $0 [-b][-c][-u]"
    echo " "
    echo "    -b          build owl file"
    echo "    -c          cleanup temporary files"
    echo "    -u          initialise/update submodules"
    echo "    -h -?       print this help"

    exit

}

while getopts "bcuh?" opt; do
    case "$opt" in
	c)
	    cleanup=1
	    ;;
	u)
	    update=1
	    ;;
	b)
	    build=1
	    ;;
	?)
	    usage
	    ;;
	h)
	    usage
	    ;;
    esac
done

if [ -z "$1" ]; then
    usage
fi


## SUBMODULES
## ==========

## Check if submodules are initialised

gitchk=$(git submodule foreach 'echo $sm_path `git rev-parse HEAD`')
if [ -z "$gitchk" ]; then
    update=1
    echo "Initialising git submodules"
fi

## Initialise and update git submodules

if [ $update -eq 1 ]; then
    git submodule init
    git submodule update
fi


## BUILD ONTOLOGY EXTENSION
## ========================

if [ $build -eq 1 ]; then


    ## DEPENDENCIES
    ## ------------

    ## Build core ontology

    cd dependencies/RDFBones-O/robot/

    ./Script-Build_RDFBones-Robot.sh

    cd ../../../

    ## Build Suchey-Brooks pubic age ontology extension

    cd dependencies/SucheyBrooksPubicAge/

    ./Script-Build_OntologyExtension-Robot.sh -b -c -u

    cd ../../
    
    ## Build Hartnett pubic age ontology extension
    
    cd dependencies/HartnettPubicAge
    
    ./Script-Build_OntologyExtension-Robot.sh -b -c -u
    
    cd ../../

    
    ## Merge dependencies

    robot merge --input dependencies/RDFBones-O/robot/results/rdfbones.owl \
	  --input dependencies/SucheyBrooksPubicAge/results/sb.owl \
	  --input dependencies/Phaleron-SexEstimation/phaleron-se.owl \
	  --input dependencies/Phaleron-SkeletalInventory/phaleron-si.owl \
	  --input dependencies/HartnettPubicAge/results/hpa.owl \
	  --output results/dependencies.owl
    
    ## Add additional dependencies files as input
    ## ******************************************


    ## TEMPLATES
    ## ---------


    ## Create category labels

    robot template --template template-category_labels.tsv \
	  --prefixes prefixes.json \
	  --input results/dependencies.owl \
	  --output results/template_CategoryLabels.owl

    robot merge --input results/dependencies.owl \
	  --input results/template_CategoryLabels.owl \
	  --output results/merged.owl


    ## Create value specifications

    robot template --template template-value_specifications.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_ValueSpecifications.owl

    robot merge --input results/merged.owl \
	  --input results/template_ValueSpecifications.owl \
	  --output results/merged.owl

    robot merge --input results/template_CategoryLabels.owl \
	  --input results/template_ValueSpecifications.owl \
	  --output results/extension.owl


    ## Create data items

    robot template --template template-data_items.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_DataItems.owl

    robot merge --input results/merged.owl \
	  --input results/template_DataItems.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_DataItems.owl \
	  --output results/extension.owl
    

    ## Create data sets

    robot template --template template-data_sets.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_DataSets.owl

    robot merge --input results/merged.owl \
	  --input results/template_DataSets.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_DataSets.owl \
	  --output results/extension.owl


    ## Create roles

    robot template --template template-roles.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_Roles.owl

    robot merge --input results/merged.owl \
	  --input results/template_Roles.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_Roles.owl \
	  --output results/extension.owl

    
    ## Create assays

    robot template --template template-assays.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_Assays.owl

    robot merge --input results/merged.owl \
	  --input results/template_Assays.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_Assays.owl \
	  --output results/extension.owl


    ## Create data transformations

    robot template --template template-data_transformations.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_DataTransformations.owl

    robot merge --input results/merged.owl \
	  --input results/template_DataTransformations.owl \
	  --output results/merged.owl


    ## Create Conclusion Processes

    robot template --template template-conclusion_processes.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_ConclusionProcesses.owl

    robot merge --input results/merged.owl \
	  --input results/template_ConclusionProcesses.owl \
	  --output results/merged.owl


    ## Create Study Design Execution Processes

    robot template --template template-study_design_executions.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_StudyDesignExecutions.owl

    robot merge --input results/merged.owl \
	  --input results/template_StudyDesignExecutions.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_StudyDesignExecutions.owl \
	  --output results/extension.owl


    ## Create Protocols

    robot template --template template-protocols.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_Protocols.owl

    robot merge --input results/merged.owl \
	  --input results/template_Protocols.owl \
	  --output results/merged.owl


    ## Create Study Designs

    robot template --template template-study_designs.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_StudyDesigns.owl

    robot merge --input results/merged.owl \
	  --input results/template_StudyDesigns.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_StudyDesigns.owl \
	  --output results/extension.owl


    ## Create Planning Processes

    robot template --template template-planning.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_Planning.owl

    robot merge --input results/merged.owl \
	  --input results/template_Planning.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_Planning.owl \
	  --output results/extension.owl


    ## Create Investigation Processes

    robot template --template template-investigations.tsv \
	  --prefixes prefixes.json \
	  --input results/merged.owl \
	  --output results/template_Investigations.owl

    robot merge --input results/merged.owl \
	  --input results/template_Investigations.owl \
	  --output results/merged.owl

    robot merge --input results/extension.owl \
	  --input results/template_Investigations.owl \
	  --output results/extension.owl

    
    ## CLEANUP TEMPORARY FILES
    ## -----------------------

    if [ $cleanup -eq 1 ]; then
	cd results
	find . -not -regex "./extension.owl" -delete
	cd ..
    fi


    ## CONSISTENCY TEST
    ## ----------------

    robot reason --reasoner ELK \
	  --input results/extension.owl \
	  -D results/debug.owl

    
    ## ANNOTATE OUTPUT
    ## ---------------

    robot annotate --input results/extension.owl \
	  --remove-annotations \
	  --ontology-iri "http://w3id.org/rdfbones/ext/phaleron-ae/latest/phaleron-ae.owl" \
	  --version-iri "http://w3id.org/rdfbones/ext/phaleron-ae/v0-1/phaleron-ae.owl" \
	  --annotation owl:versionInfo "0.1" \
	  --language-annotation rdfs:label "Phaleron Biological Project Age Estimation" en \
	  --language-annotation rdfs:comment "This RDFBones ontology extension is part of the suite of ontology extensions created for and used by the Phaleron Bioarchaeological Project. In order to work properly, it depends on the RDFBones core ontology, the Phaleron Sex Estimation ontology extension and the Suchey Brooks Pubic Age ontology extension. Make sure that these are loaded on your system before starting work with this ontology extension." en \
	  --annotation dc:creator "Felix Engel" \
	  --annotation dc:contributor "Stefan Schlager" \
	  --annotation dc:contributor "Lukas Bender" \
	  --language-annotation dc:description "This RDFBones ontology extension implements the routines for estimating age at death from human skeletal remains as employed by the Phaleron Bioarchaeological Project." en \
	  --language-annotation dc:title "Phaleron Bioarchaeological Project Age Estimation" en \
	  --output results/phaleron-ae.owl

    ## Change annotations to describe your extension and change file name in the final output statement.
    ## *************************************************************************************************

    
    ## CLEANUP TEMPORARY FILES
    ## -----------------------

    if [ $cleanup -eq 1 ]; then
	rm results/extension.owl
    fi

fi


## CLEANUP
## =======


## CLEANUP TEMPORARY FILES IN DEPENDENCIES
## ---------------------------------------

## Remove temporary build files in RDFBones core ontology

FILE=dependencies/RDFBones-O/robot/results/
if [ -f "$FILE" ]; then
    rm -r dependencies/RDFBones-O/robot/results/
fi

FILE=dependencies/SucheyBrooksPubicAge/results/

if [ -f "$FILE" ]; then
    rm -r dependencies/SucheyBrooksPubicAge/results/
fi

## Add cleanup commands for additional dependencies as exemplified above for the RDFBones core ontology.
## *****************************************************************************************************
