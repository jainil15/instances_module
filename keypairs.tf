resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
}

# Public key loaded from a terraform-generated private key, using the PEM (RFC 1421) format
data "tls_public_key" "this" {
  private_key_openssh = var.private_key
}


# Creating key pair for ssh access
resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.env}-mykeypair"
  public_key = data.tls_public_key.this.public_key_openssh
}
