#Proveedor aws
provider "aws" {
  region = "us-east-1"
}

#Creamos el Security Group
resource "aws_security_group" "mi-sg-2" {
  name = "mi-security-group-terraform-2"
  description = "Security group para instancia de Terraform"
  vpc_id = "vpc-098881630d1255eba"
  #regla de entrada para ssh y salida para http
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#declaracion de recursos aws, todo lo que quiera aprovisionar desde tf se llama recurso
resource "aws_instance" "mi_instancia_windows" {
  ami = "ami-0b5f645abc199e666"
  #familia
  instance_type = "t3.micro"
  key_name      = "mi-primera-llave-ac"
  tags = {
    Name = "MiInstanciaTerraformWin"
  }
  vpc_security_group_ids = [ aws_security_group.mi-sg-2.id ] #Asignamos el security group a la instancia
}
