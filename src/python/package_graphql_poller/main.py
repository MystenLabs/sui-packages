# Copyright (c) 2024 Mysten Labs, Inc.
# SPDX-License-Identifier: Apache-2.0

from os import listdir, makedirs, path

import argparse
import base64
import json
import requests

NETWORK_TO_ORIGIN = {
    "mainnet": "https://sui-mainnet.mystenlabs.com",
    "testnet": "https://sui-testnet.mystenlabs.com",
}

QUERY = """
query($cursor: String, $afterCheckpoint: UInt53) {
  packages(first: 50  after: $cursor, filter: {afterCheckpoint: $afterCheckpoint}) {
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      address
      version
      digest
      previousTransactionBlock {
        digest
        sender {
          address
        }
        effects {
          checkpoint {
            sequenceNumber
          }
        }
      }
      packageVersions(first: 1) {
        nodes {
          address
          version
        }
      }
      modules {
        nodes {
          name
          bytes
        }
      }
      linkage {
        originalId
        upgradedId
        version
      }
      typeOrigins {
        module
        struct
        definingId
      }
    }
  }
}
"""


def query_graphql(network, query, variables):
    origin = NETWORK_TO_ORIGIN.get(network)
    if not origin:
        raise Exception(f"unknown network: {network}")
    body = {"query": query, "variables": variables}
    resp = requests.post(
        f"{origin}/graphql",
        headers={
            "User-Agent": "sui-integrity (https://github.com/MystenLabs/sui-integrity)",
            "Content-Type": "application/json",
        },
        json=body,
    )
    return resp


def get_last_checkpoint_seen(io_dir, network):
    "Iterates over $io_dir/$network/$first_4/$last_n/metadata.json and returns the highest checkpoint number"
    max_checkpoint = 0
    network_dir = path.join(io_dir, network)
    for first_4_dir in listdir(network_dir):
        for last_n_dir in listdir(path.join(network_dir, first_4_dir)):
            metadata_file = path.join(
                network_dir, first_4_dir, last_n_dir, "metadata.json"
            )
            if not path.isfile(metadata_file):
                print(f"Missing {first_4_dir}/{last_n_dir}/metadata.json")
                continue
            with open(metadata_file, "r") as f:
                metadata = json.load(f)
                checkpoint = metadata["checkpoint"]
                if checkpoint > max_checkpoint:
                    max_checkpoint = checkpoint
    return max_checkpoint


def package_node_to_metadata_and_modules(node):
    id = node["address"]
    originalPackageId = node["packageVersions"]["nodes"][0]["address"]
    version = node["version"]
    sender_node = node["previousTransactionBlock"]["sender"]
    sender = sender_node["address"] if sender_node else 0
    transactionDigest = node["previousTransactionBlock"]["digest"]
    checkpoint = node["previousTransactionBlock"]["effects"]["checkpoint"][
        "sequenceNumber"
    ]
    metadata = {}
    metadata["id"] = id
    metadata["originalPackageId"] = originalPackageId
    metadata["version"] = version
    metadata["sender"] = sender
    metadata["transactionDigest"] = transactionDigest
    metadata["checkpoint"] = checkpoint

    bcs = {"dataType": "package"}
    bcs["id"] = id
    bcs["version"] = version
    bcs["moduleMap"] = {}
    bcs["typeOriginTable"] = []
    bcs["linkageTable"] = {}

    module_nodes = node["modules"]["nodes"]
    modules = []
    for module_node in module_nodes:
        module_name = module_node["name"]
        module_b64 = module_node["bytes"]

        bcs["moduleMap"][module_name] = module_b64

        modules.append({"name": module_name, "bytes": base64.b64decode(module_b64)})

    for nto in node["typeOrigins"]:
        bcs["typeOriginTable"].append(
            {
                "module_name": nto["module"],
                "datatype_name": nto["struct"],
                "package": nto["definingId"],
            }
        )

    for linkage_entry in node["linkage"]:
        lt = {}
        bcs["linkageTable"][linkage_entry["originalId"]] = lt
        lt["upgraded_id"] = linkage_entry["upgradedId"]
        lt["upgraded_version"] = linkage_entry["version"]

    res = {"bcs": bcs, "metadata": metadata, "modules": modules}
    return res


def get_packages_published_after_checkpoint(
    network,
    io_dir,
    checkpoint=None,
    on_package=lambda io_dir, network, package: None,
):
    cursor = None
    has_next = True
    packages_with_metadata = []
    while has_next:
        resp = query_graphql(
            network, QUERY, {"cursor": cursor, "afterCheckpoint": checkpoint}
        )
        if resp.status_code == 200:
            body = json.loads(resp.content)

            packages_graphql = body["data"]["packages"]["nodes"]
            for p in packages_graphql:
                pkg = package_node_to_metadata_and_modules(p)
                if pkg["metadata"]["sender"]:
                    # sender is only truthy for PTB packages, and not for system packages
                    on_package(io_dir, network, pkg)
                    packages_with_metadata.append(pkg)
            has_next = body["data"]["packages"]["pageInfo"]["hasNextPage"]
            if has_next:
                cursor = body["data"]["packages"]["pageInfo"]["endCursor"]
    return packages_with_metadata


def save_package_info(io_dir, network, package):
    package_id = package["metadata"]["id"]
    create_package_dir(io_dir, network, package_id)
    write_package_bcs(io_dir, network, package)
    write_package_metadata(io_dir, network, package)
    write_package_bytecode(io_dir, network, package)


def write_package_bytecode(io_dir, network, package):
    metadata = package["metadata"]
    package_dir = get_and_create_bytecode_dir_for_package(
        io_dir, network, metadata["id"]
    )
    modules = package["modules"]
    for m in modules:
        module_file = path.join(package_dir, f"""{m["name"]}.mv""")
        with open(module_file, "wb") as f:
            f.write(m["bytes"])


def write_package_bcs(io_dir, network, package):
    package_id = package["metadata"]["id"]
    with open(get_bcs_file_name(io_dir, network, package_id), "w") as fw:
        json.dump(package["bcs"], fw, indent=2)


def write_package_metadata(io_dir, network, package):
    package_id = package["metadata"]["id"]
    with open(get_metadata_file_name(io_dir, network, package_id), "w") as fw:
        json.dump(package["metadata"], fw, indent=2)


def get_package_dir(io_dir, network, package_id):
    return path.join(io_dir, network, package_id[:4], package_id[4:])


def get_bcs_file_name(io_dir, network, package_id):
    return path.join(get_package_dir(io_dir, network, package_id), "bcs.json")


def get_metadata_file_name(io_dir, network, package_id):
    return path.join(get_package_dir(io_dir, network, package_id), "metadata.json")


def create_package_dir(io_dir, network, package_id):
    package_dir = get_package_dir(io_dir, network, package_id)
    makedirs(package_dir, exist_ok=True)


def get_and_create_bytecode_dir_for_package(io_dir, network, package_id):
    package_dir = get_package_dir(io_dir, network, package_id)
    bytecode_dir = path.join(package_dir, "bytecode")
    makedirs(bytecode_dir, exist_ok=True)
    return bytecode_dir


if __name__ == "__main__":
    arg_parser = argparse.ArgumentParser(
        prog="package-graphql-poller",
        description="Polls GraphQL and writes package metadata, bcs, and bytecode",
    )
    arg_parser.add_argument(
        "--io-dir",
        required=True,
        help="The root directory (without the network) where packages are going to be written to",
    )

    arg_parser.add_argument(
        "--network", required=True, help="The network (e.g. mainnet, testnet)"
    )

    args = arg_parser.parse_args()
    io_dir = args.io_dir
    network = args.network

    last_checkpoint_seen = get_last_checkpoint_seen(io_dir, network)
    print(f"Last checkpoint seen: {last_checkpoint_seen}")

    new_packages_with_metadata = get_packages_published_after_checkpoint(
        network,
        io_dir,
        checkpoint=last_checkpoint_seen,
        on_package=save_package_info,
    )
    new_metadata = [p["metadata"] for p in new_packages_with_metadata]
