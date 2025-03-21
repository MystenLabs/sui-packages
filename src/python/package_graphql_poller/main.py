# Copyright (c) 2024 Mysten Labs, Inc.
# SPDX-License-Identifier: Apache-2.0

from os import listdir, makedirs, path

import argparse
import base64
import json
import subprocess
import requests

NETWORK_TO_ORIGIN_GRAPHQL = {
    "mainnet": "https://sui-mainnet.mystenlabs.com",
    "testnet": "https://sui-testnet.mystenlabs.com",
}

NETWORK_TO_ORIGIN_JSONRPC = {
    "mainnet": "https://fullnode.mainnet.sui.io",
    "testnet": "https://fullnode.testnet.sui.io",
}

PACKAGES_QUERY = """
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
          functions {
            nodes {
              visibility
              isEntry
              name
              parameters {
                repr
              }
              return {
                repr
              }
            }
          }
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

PACKAGES_QUERY_NO_TRANS = """
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
          functions {
            nodes {
              visibility
              isEntry
              name
              parameters {
                repr
              }
              return {
                repr
              }
            }
          }
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

TRANSACTION_BLOCK_QUERY = """
query($cursor: String, $afterCheckpoint: UInt53) {
	  transactionBlocks(
    first: 50
    after: $cursor
    filter: {afterCheckpoint: $afterCheckpoint, kind: PROGRAMMABLE_TX}
  ) {
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      digest
      sender {
        address
      }
      effects {
       checkpoint {
          sequenceNumber
        }
        objectChanges {
          nodes {
   				address
          }
        }
      }
    }
  }
"""

def query_graphql(network, query, variables):
    origin = NETWORK_TO_ORIGIN_GRAPHQL.get(network)
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

def query_jsonrpc(network, query):
    origin = NETWORK_TO_ORIGIN_JSONRPC.get(network)
    if not origin:
        raise Exception(f"unknown network: {network}")
    resp = requests.post(
        origin,
        headers={
            "User-Agent": "sui-integrity (https://github.com/MystenLabs/sui-integrity)",
            "Content-Type": "application/json",
        },
        json=query,
    )
    return resp

def multiGetObject_jsonrpc(network, objects, options):
    query = {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "sui_multiGetObjects",
            "params": [
                objects,
                options
            ]
    }
    resp = query_jsonrpc(network, query)
    objects = {}
    if resp.status_code == 200:
        resp_json = resp.json()
        for data in resp_json["result"]:
            objects[data['data']['objectId']] = data['data']
    
    return objects

def multiGetTransactionBlocks_jsonrpc(network, transactions, options):
    query = {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "sui_multiGetTransactionBlocks",
            "params": [
                transactions,
                options
            ]
    }
    resp = query_jsonrpc(network, query)
    transactions = {}
    if resp.status_code == 200:
        resp_json = resp.json()
        for data in resp_json["result"]:
            transactions[data['digest']] = data
    
    return transactions

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
    bcs["functionMap"] = {}

    module_nodes = node["modules"]["nodes"]
    modules = []
    for module_node in module_nodes:
        module_name = module_node["name"]
        module_b64 = module_node["bytes"]
        
        bcs["functionMap"][module_name] = {}
        if module_node["functions"]:
            module_functions = module_node["functions"]["nodes"]
            for f in module_functions:
                f_name = f["name"]
                f_visibility = f["visibility"]
                f_is_entry = f["isEntry"]
                f_params = []
                f_return = None
                for param in f["parameters"]:
                    f_params.append(param["repr"])
                if f["return"] and 'repr' in f["return"]:
                    f_return = f["return"]['repr']
                bcs["functionMap"][module_name][f_name] = {
                    "visibility": f_visibility,
                    "is_entry": f_is_entry,
                    "params": f_params,
                    "return": f_return
                }

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

def add_previous_transaction_data(network, packages):
    package_ids = [p["address"] for p in packages]
    packages_metadata = multiGetObject_jsonrpc(network, package_ids, {"showPreviousTransaction": True})
    previous_transaction_digests = [p['previousTransaction'] for p in packages_metadata.values()]
    transactions = multiGetTransactionBlocks_jsonrpc(network, previous_transaction_digests, {"showEffects": True, "showInput": True})
    for p in packages:
        previous_transaction_digest = packages_metadata[p["address"]]['previousTransaction']
        p["previousTransactionBlock"] = {'digest': previous_transaction_digest, 
                                         'sender': {'address': transactions[previous_transaction_digest]['transaction']['data']['sender']} if transactions[previous_transaction_digest]['transaction']['data']['sender']  else  None,
                                         'effects': {'checkpoint': {'sequenceNumber': int(transactions[previous_transaction_digest]['checkpoint'])}}}
    
    
    
def get_packages_published_after_checkpoint(
    network,
    io_dir,
    checkpoint=None,
    on_package=lambda io_dir, network, package: None,
    move_decompiler_path=None
):
    cursor = None
    has_next = True
    packages_with_metadata = []
    package_query = PACKAGES_QUERY
    no_trans_graphql = False

    while has_next:
        resp = query_graphql(
            network, package_query, {"cursor": cursor, "afterCheckpoint": checkpoint}
         )
        if resp.status_code != 200 or not  json.loads(resp.content)['data']:
            if cursor:
               checkpoint =  max(p['metadata']['checkpoint'] for p in packages_with_metadata.values())
               cursor = None

            package_query = PACKAGES_QUERY_NO_TRANS
            no_trans_graphql = True            

            resp = query_graphql(
                    network, package_query, {"cursor": cursor, "afterCheckpoint": checkpoint}
                )
        
        if resp.status_code == 200:
            body = json.loads(resp.content)

            packages_graphql = body.get("data", {}).get("packages", {}).get("nodes", [])
            if no_trans_graphql:
                add_previous_transaction_data(network, packages_graphql)
                
            for p in packages_graphql:
                pkg = package_node_to_metadata_and_modules(p)
                if pkg["metadata"]["sender"]:
                    # sender is only truthy for PTB packages, and not for system packages
                    on_package(io_dir, network, pkg, move_decompiler_path)
                    packages_with_metadata.append(pkg)
            has_next = body["data"]["packages"]["pageInfo"]["hasNextPage"]
            if has_next:
                cursor = body["data"]["packages"]["pageInfo"]["endCursor"]
        else:
            print(f"Failed to query packages: {resp.status_code}")
    return packages_with_metadata


def save_package_info(io_dir, network, package, move_decompiler_path):
    package_id = package["metadata"]["id"]
    create_package_dir(io_dir, network, package_id)
    write_package_bcs(io_dir, network, package)
    write_package_metadata(io_dir, network, package)
    write_package_bytecode_and_decompiled(io_dir, network, package, move_decompiler_path)


def write_package_bytecode_and_decompiled(io_dir, network, package, move_decompiler_path):
    metadata = package["metadata"]
    bytecode_dir, decompiled_dir = get_and_create_bytecode_and_decompiled_dir_for_package(
        io_dir, network, metadata["id"]
    )
    modules = package["modules"]
    for m in modules:
        module_file = path.join(bytecode_dir, f"""{m["name"]}.mv""")
        with open(module_file, "wb") as f:
            f.write(m["bytes"])
        
        decompiled_file = path.join(decompiled_dir, f"""{m["name"]}.move""")
        subprocess.run([move_decompiler_path, "--bytecode", module_file], stdout=open(decompiled_file, "w"))


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


def get_and_create_bytecode_and_decompiled_dir_for_package(io_dir, network, package_id):
    package_dir = get_package_dir(io_dir, network, package_id)
    bytecode_dir = path.join(package_dir, "bytecode_modules")
    decompiled_dir = path.join(package_dir, "decompiled_modules")

    makedirs(name=bytecode_dir, exist_ok=True)
    makedirs(name=decompiled_dir, exist_ok=True)
    return bytecode_dir, decompiled_dir


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

    arg_parser.add_argument(
        "--move-decompiler", required=True, help="The move-decompiler binary to be used"
    )

    args = arg_parser.parse_args()
    io_dir = args.io_dir
    network = args.network
    move_decompiler_path = args.move_decompiler


    last_checkpoint_seen = get_last_checkpoint_seen(io_dir, network)
    print(f"Last checkpoint seen: {last_checkpoint_seen}")

    new_packages_with_metadata = get_packages_published_after_checkpoint(
        network,
        io_dir,
        checkpoint=last_checkpoint_seen,
        on_package=save_package_info,
        move_decompiler_path=move_decompiler_path
    )
    new_metadata = [p["metadata"] for p in new_packages_with_metadata]
