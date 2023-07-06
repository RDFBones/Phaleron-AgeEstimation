
# ROBOT Template For RDFBones Ontology Extensions
This is a ROBOT template for authors of ontology extensions to the [RDFBones core ontology](https://github.com/RDFBones/RDFBones-O). [ROBOT](http://robot.obolibrary.org) is a tool for the development of ontologies that are based on the [Resource Description Framework](https://www.w3.org/RDF/).

To use this template, you need to install ROBOT, following the [instructions on their website](http://robot.obolibrary.org/).

All files required by ROBOT are on the 'robot' branch.

## How To Use the Template

Note that within the bash script '[Script-Build_OntologyExtension-Robot.sh](https://github.com/RDFBones/ExtensionTemplate/blob/robot/Script-Build_OntologyExtension-Robot.sh) comments addressing users are formatted like this:

`## This is what you need to do`

`## ***************************`

Create a duplicate of this repository, either by using GitHub's templating mechanism or by cloning. Then take the following steps:
1. Check out the 'robot' branch. 
2. Open the file '[prefixes.json](https://github.com/RDFBones/ExtensionTemplate/blob/robot/prefixes.json)' in a text editor. Replace the last line, `"template" : "http://w3id.org/rdfbones/ext/template/"` with a prefix for your own extension. You need to define a prefix (replacing `template`) and a URI (replacing `http://w3id.org/rdfbones/ext/template/`).
3. *If your extension has dependencies* (i.e. needs other RDFBones ontology extensions to work) other than the RDFBones core ontology, add their repositories as git submodules in the directory [dependencies](https://github.com/RDFBones/ExtensionTemplate/tree/robot/dependencies).
4. Open the bash script '[Script-Build_OntologyExtension-Robot.sh](https://github.com/RDFBones/ExtensionTemplate/blob/robot/Script-Build_OntologyExtension-Robot.sh). *If your extension has dependencies that need the execution of some script to be built*, add the required commands beneath [line 87](https://github.com/RDFBones/ExtensionTemplate/blob/f3f344fd9bff62de8fc9a223bfadb57ea79d9a76/Script-Build_OntologyExtension-Robot.sh#L87). Use the commands for building the RDFBones core ontology in [lines 81 to 87](https://github.com/RDFBones/ExtensionTemplate/blob/f3f344fd9bff62de8fc9a223bfadb57ea79d9a76/Script-Build_OntologyExtension-Robot.sh#L82C1-L87) as an example.
5. *If your extension has dependencies that need the execution of some script to be built*, you can 
6. *If you have added dependencies*, add the required files from the submodules you have created above as additional input to the merge command in [line 94](https://github.com/RDFBones/ExtensionTemplate/blob/f3f344fd9bff62de8fc9a223bfadb57ea79d9a76/Script-Build_OntologyExtension-Robot.sh#L94).
7. In the bash script, change the contents of the annotations in [lines 272 to 281](https://github.com/RDFBones/ExtensionTemplate/blob/f3f344fd9bff62de8fc9a223bfadb57ea79d9a76/Script-Build_OntologyExtension-Robot.sh#L272-L281) to suit your extension.
8. In the bash script, change the file name in the ROBOT output statement in [line 282](https://github.com/RDFBones/ExtensionTemplate/blob/f3f344fd9bff62de8fc9a223bfadb57ea79d9a76/Script-Build_OntologyExtension-Robot.sh#L282) to reflect your extension's name.
9. Open the file '[template-category_labels.tsv](https://github.com/RDFBones/ExtensionTemplate/blob/robot/template-category_labels.tsv)' in a spreadsheet editor. Lines 1 and 2 contain header information that you need to keep by all means. The following lines contain definitions for some sample entities. Replace these with definitions for your own extension. Use the prefix defined above. If your extension does not contain any categorical labels, just delete the lines with the sample entities.
10. Open the file '[template-value_specifications.tsv](https://github.com/RDFBones/ExtensionTemplate/blob/robot/template-value_specifications.tsv)' and process value specifications in your extensions in the same way as explained above for categorical labels.
11. Open the file '[template-data_items.tsv](https://github.com/RDFBones/ExtensionTemplate/blob/robot/template-data_items.tsv)' and process data items in your extension in the same way as explained above for categorical labels.
12. Open the file '[template-data_sets.tsv](https://github.com/RDFBones/PubicAgeDetermination/blob/robot/template-data_sets.tsv)' and process data sets in your extension in the same way as explaihttps://github.com/RDFBones/ExtensionTemplate/blob/robot/Script-Build_OntologyExtension-Robot.shned above for categorical labels.
13. Open the file '[template-assays.tsv](https://github.com/RDFBones/PubicAgeDetermination/blob/robot/template-assays.tsv)' and process assays in your extension in the same way as explained above for categorical labels.
14. Open the file '[template-data_transformations.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-data_transformations.tsv)' and process data transformation processes in your extension in the same way as explained above for categorical labels.
15. Open the file '[template-conclusion_processes.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-conclusion_processes.tsv)' and process conclusion processes in your extension in the same way as explained above for categorical labels.
16. Open the file '[template-study_design_executions.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-study_design_executions.tsv)' and process study design execution processes in your extension in the same way as explained above for categorical labels.
17. Open the file '[template-protocols.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-protocols.tsv)' and process protocols that your extension is based on in the same way as explained above for categorical labels.
18. Open the file '[template-study_designs.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-study_designs.tsv)' and process the study design of your extension in the same way as explained above for categorical labels.
19. Open the file '[template-planning.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-planning.tsv)' and process the planning process of your extension in the same way as explained above for categorical labels.
20. Open the file '[template-investigations.tsv](https://github.com/RDFBones/SucheyBrooksPubicAge/blob/robot/template-investigations.tsv)' and process information about the investigation your extension describes in the same way as explained above for categorical labels.
21. Open your local instance of the repository in the terminal and execute the bash script: `./Script-Build_OntologyExtension-Robot.sh -b -u` Type `./Script-Build_OntologyExtension-Robot.sh -h` to get a list of all available options. You will find the OWL file of your extension in the ./results/ directory.
