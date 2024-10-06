#include <torch/torch.h>
#include <iostream>

int main() {
  torch::Tensor tensor = torch::eye(3);
  if (torch::cuda::is_available()) {
    std::cout << "CUDA is available! Training on GPU." << std::endl;
    tensor = tensor.to(torch::kCUDA);
  } else {
    std::cout << "CUDA is not available! Training on CPU." << std::endl;
  }
  std::cout << tensor << std::endl;
}
