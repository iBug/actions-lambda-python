AWS_DEFAULT_REGION ?= us-east-1
ZIP_FILE = package.zip
PIP_DIR = packages

.PHONY: all clean clean-all install-deps package deploy

all: deploy

clean:
	rm -f $(ZIP_FILE)

clean-all: clean
	rm -rf $(PIP_DIR)

deploy: $(ZIP_FILE)
	AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} aws lambda update-function-code --function-name ${AWS_FUNCTION_NAME} --zip-file fileb://$<

$(ZIP_FILE): $(wildcard *.py) | $(PIP_DIR)
	( cd $(PIP_DIR); zip -r ../$@ ./ )
	zip -g $@ $^

$(PIP_DIR): requirements.txt
	pip3 install -t $@ -r $<

install-deps: $(PIP_DIR)

package: $(ZIP_FILE)
