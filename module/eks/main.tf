resource "aws_eks_cluster" "eks-cluster" {
  name     = "eks-cluster"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = [for v in var.pub-snet: v.snet-id]
    security_group_ids = [var.cluster-sg]
  }
}

resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "my-cluster"
  node_role_arn   = var.woker_role_arn
  subnet_ids      = [for v in var.pub-snet: v.snet-id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}