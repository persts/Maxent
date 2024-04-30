
preflight:
	javac -d bin -g src/resources/com/macfaq/io/Little*.java
	javac -d bin -g src/resources/gnu/getopt/Getopt.java src/resources/gnu/getopt/LongOpt.java
	javac -d bin -g src/resources/gui/layouts/*.java
	javac -d bin -g -classpath src/resources src/resources/ptolemy/plot/*.java
	
	javac -d bin -g -classpath src:src/resources src/maxent/ParamsPre.java
	java -classpath bin:src maxent.ParamsPre typesafe > src/maxent/Params.java
	javac -d bin -g -classpath src:src/resources src/maxent/*.java
	javac -d bin -g -classpath src:src/resources src/maxent/tools/*.java

	cat src/maxent/help.html.pre > bin/maxent/help.html
	java -classpath bin:src maxent.Params write >> bin/maxent/help.html 
	echo "</blockquote><br></body></html>" >> bin/maxent/help.html

	javadoc -d html -classpath src:src/resources src/maxent/Runner.java src/maxent/Params.java src/maxent/ParamsPre.java src/maxent/Evaluate.java
	zip maxentdoc.zip html/maxent/Runner.html html/maxent/Params.html html/maxent/ParamsPre.html html/maxent/Evaluate.html

distribution: preflight
	jar cvfm maxent.jar src/maxent/mc.mf bin/maxent/*.class bin/maxent/*.html bin/gnu/getopt/*.class bin/gui/layouts/*.class bin/com/macfaq/io/LittleEndian*.class bin/maxent/tools/*.class bin/ptolemy/plot/*.class src/maxent/parameters.csv
	zip maxent.zip maxent.jar readme.txt maxent.bat


