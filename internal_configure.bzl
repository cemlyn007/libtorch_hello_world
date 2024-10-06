"""Module extension for "configuring" libtorch_bazel."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_INTEGRITIES = {
    # Generate with "sha256-$(curl -fsSL "$url" | sha256sum | cut -d' ' -f1 | xxd -r -p | base64)"
    "2.4.1": {
        "linux": "sha256-6+3DGHVt0SIpZEvySnZDThog90kb403wponxUUQPCgo=",
        "darwin": "sha256-2ackf8X8D7n/G0+4bgDXuYuQJvrAXUfYkkPhjRRg4hE="
    },
}

_URLS = {
    "2.4.1": {
        "linux": "https://download.pytorch.org/libtorch/cu124/libtorch-cxx11-abi-shared-with-deps-2.4.1%2Bcu124.zip",
        "darwin": "https://download.pytorch.org/libtorch/cpu/libtorch-macos-arm64-2.4.1.zip",
    }
}

def _internal_configure_extension_impl(module_ctx):
    (libtorch,) = [module for module in module_ctx.modules if module.name == "libtorch_bazel"]
    version = libtorch.version

    # TODO
    platform = "linux"

    # The libtorch_bazel version should typically just be the libtorch version,
    # but can end with ".bzl.<N>" if the Bazel plumbing was updated separately.
    version = version.split(".bzl.")[0]
    http_archive(
        name = "libtorch",
        build_file = "//:libtorch-BUILD.bazel",
        strip_prefix = "libtorch",
        url = _URLS.get(version).get(platform),
        integrity = _INTEGRITIES.get(version).get(platform),
    )

internal_configure_extension = module_extension(implementation = _internal_configure_extension_impl)
