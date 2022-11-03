# Salesforce Exercise -- Page Layout Retrieval

Please implement the function `getLayoutNamesForObject(String objectName)` available in the LayoutRetrieval.cls class
that will:

- Leverage the given Metadata API to return all of the possible layout names for a given Salesforce object
- You may use the function `connectToFoxiteSign` as reference for how to leverage the Metadata API (in this case it is used for creating both an Authorization Provider and a  Named Credential).
- Please make sure that the List of Strings is sorted Alphabetically.
- Please create at least one test class for this function in the LayoutRetrievalTest class for any object generally available in any organization
- A successful run of this function will look like the following:
    - Input in Developer Console:
        ```
        List<String> layoutNames = CustomButtonController.getLayoutNamesForObject('Opportunity');

        System.debug(layoutNames);
        ```

    - Example System Debug Output in Developer Console:
        ```(Opportunity-Opportunity (Marketing) Layout, Opportunity-Opportunity (Sales) Layout, Opportunity-Opportunity (Support) Layout)```
- You may find the specification for Layouts [here])https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_layouts.htm)




# Salesforce DX Project: Setting up development environment

Please install the following programs into your computer
- [Visual Studio Code](https://code.visualstudio.com/)
- [SFDX (Salesforce CLI)](https://trailhead.salesforce.com/content/learn/projects/quick-start-salesforce-dx/set-up-your-salesforce-dx-environment): 

# Create a scratch org 
Create a scratch org, set it as your default, and give it an alias:

```sfdx force:org:create -s -f config/project-scratch-def.json -a dreamhouse-org```

Typically, the command completes in less than a minute. You get two items in the output: the org ID and the username.

Image shows creating a scratch orgNotice that we didn’t get a password. This is because Salesforce DX uses cached authentication tokens.

# Open the scratch org 

Open the scratch org you just created by running the command:

```sfdx force:org:open```

Because you set the scratch org as default using the -s flag, the system remembers stores the authentication token and uses it to log in for you. The -s flag saves you time from having to manually log in and remember passwords later.

Next, push the salesforce-exercise project this repository includes to the new scratch org.

```sfdx force:source:push```

It takes a few moments, but all the metadata is pushed into the scratch org. The terminal window displays the list of resources that successfully pushed.





