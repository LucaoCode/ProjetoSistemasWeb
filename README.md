# ProjetoSistemasWeb

## Pet Shop Architecture with Terraform

Este repositório contém uma configuração do Terraform para provisionar uma arquitetura básica para um aplicativo de pet shop na AWS. A arquitetura inclui recursos principais para frontend, backend, banco de dados, funções Lambda, API Gateway, SNS para notificações e CloudWatch para monitoramento.

Arquitetura
Cliente Móvel:

Representa usuários acessando o aplicativo via dispositivos móveis.
Frontend:

Amazon S3: Armazena e serve arquivos estáticos do site.
Backend:

Amazon EC2: Executa a lógica de negócios do aplicativo.
AWS Lambda:
Image Processing Lambda: Processa imagens enviadas pelos usuários.
Notification Lambda: Envia notificações para os usuários.
Banco de Dados:

Amazon RDS: Armazena dados sobre clientes e pets.
API Gateway:

Gerencia e roteia chamadas de API para a instância EC2.
SNS (Simple Notification Service):

Para enviar e receber mensagens e notificações.
CloudWatch:

Para monitoramento e logs dos recursos da AWS.
Arquitetura Diagrama
O diagrama abaixo ilustra a arquitetura configurada com o Terraform:


Recursos
S3 Bucket: Para armazenar arquivos estáticos.
EC2 Instance: Para a lógica de backend.
Lambda Functions: Para processamento assíncrono e notificações.
RDS Database: Para armazenamento de dados.
API Gateway: Para gerenciar chamadas de API.
SNS Topic: Para notificações e mensagens.
CloudWatch Logs: Para monitoramento e logs.