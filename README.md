# azure-aifoundry-template
Azure AI Foundry Template to create Resources using Bicep

## Introduction
This template provides a streamlined approach to deploying Azure resources with Bicep. It is designed to simplify infrastructure as code practices and serve as a starting point to deploy secure and scalable resources on Azure.

## Prerequisites
- **Azure CLI:** Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) to interact with your Azure resources.
- **Bicep CLI:** Ensure the [Bicep CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) is installed to compile and deploy your Bicep templates.
- **Azure Subscription:** You must have an active [Azure subscription](https://azure.microsoft.com/free/).
- **Permissions:** Ensure you have sufficient permissions to deploy resources within your subscription.
- **Visual Studio Code (Optional):** For an enhanced development experience, it is recommended to use [Visual Studio Code](https://code.visualstudio.com/) along with the Bicep extension.

# Disclaimer
This template is provided as a starting point and may require customization based on your specific requirements. It is recommended to review and modify the template to suit your needs.

If you need to deploy in production, check the [2](https://learn.microsoft.com/en-us/samples/azure-samples/azure-ai-studio-secure-bicep/azure-ai-studio-secure-bicep/) for a more secure deployment.

## Usage
1. Clone this repository to your local machine.
2. Navigate to the cloned directory.
3. Run the following command to compile the Bicep template:

```bash
bicep build main.bicep
```
4. Once the compilation is successful, you can deploy the resources using the following command:
```bash
az deployment group create --resource-group <resource-group-name> --template-file main.json
```

# Reference
1. [Azure AI Foundry Simple Template](https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/create-azure-ai-hub-template?tabs=cli)
2. [Deploy Secure Azure Ai Foundry via Bicep](https://learn.microsoft.com/en-us/samples/azure-samples/azure-ai-studio-secure-bicep/azure-ai-studio-secure-bicep/)

