module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node {
    struct StorageNodeInfo has store {
        name: 0x1::string::String,
        node_id: 0x2::object::ID,
        network_address: 0x1::string::String,
        public_key: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>,
        next_epoch_public_key: 0x1::option::Option<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>,
        network_public_key: vector<u8>,
        metadata: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::ExtendedField<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata>,
    }

    struct StorageNodeCap has store, key {
        id: 0x2::object::UID,
        node_id: 0x2::object::ID,
        last_epoch_sync_done: u32,
        last_event_blob_attestation: 0x1::option::Option<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>,
        deny_list_root: u256,
        deny_list_sequence: u64,
        deny_list_size: u64,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata, arg6: &mut 0x2::tx_context::TxContext) : StorageNodeInfo {
        assert!(0x1::vector::length<u8>(&arg4) == 33, 0);
        let v0 = 0x2::bls12381::g1_from_bytes(&arg3);
        StorageNodeInfo{
            name                  : arg0,
            node_id               : arg1,
            network_address       : arg2,
            public_key            : 0x2::bls12381::g1_to_uncompressed_g1(&v0),
            next_epoch_public_key : 0x1::option::none<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(),
            network_public_key    : arg4,
            metadata              : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::new<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata>(arg5, arg6),
        }
    }

    public(friend) fun destroy(arg0: StorageNodeInfo) {
        let StorageNodeInfo {
            name                  : _,
            node_id               : _,
            network_address       : _,
            public_key            : _,
            next_epoch_public_key : _,
            network_public_key    : _,
            metadata              : v6,
        } = arg0;
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::destroy<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata>(v6);
    }

    public fun deny_list_root(arg0: &StorageNodeCap) : u256 {
        arg0.deny_list_root
    }

    public fun deny_list_sequence(arg0: &StorageNodeCap) : u64 {
        arg0.deny_list_sequence
    }

    public fun id(arg0: &StorageNodeInfo) : 0x2::object::ID {
        arg0.node_id
    }

    public fun last_epoch_sync_done(arg0: &StorageNodeCap) : u32 {
        arg0.last_epoch_sync_done
    }

    public fun last_event_blob_attestation(arg0: &mut StorageNodeCap) : 0x1::option::Option<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation> {
        arg0.last_event_blob_attestation
    }

    public(friend) fun metadata(arg0: &StorageNodeInfo) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata {
        *0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::borrow<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata>(&arg0.metadata)
    }

    public(friend) fun new_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : StorageNodeCap {
        StorageNodeCap{
            id                          : 0x2::object::new(arg1),
            node_id                     : arg0,
            last_epoch_sync_done        : 0,
            last_event_blob_attestation : 0x1::option::none<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>(),
            deny_list_root              : 0,
            deny_list_sequence          : 0,
            deny_list_size              : 0,
        }
    }

    public(friend) fun next_epoch_public_key(arg0: &StorageNodeInfo) : &0x2::group_ops::Element<0x2::bls12381::UncompressedG1> {
        0x1::option::borrow_with_default<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&arg0.next_epoch_public_key, &arg0.public_key)
    }

    public fun node_id(arg0: &StorageNodeCap) : 0x2::object::ID {
        arg0.node_id
    }

    public(friend) fun public_key(arg0: &StorageNodeInfo) : &0x2::group_ops::Element<0x2::bls12381::UncompressedG1> {
        &arg0.public_key
    }

    public(friend) fun rotate_public_key(arg0: &mut StorageNodeInfo) {
        if (0x1::option::is_some<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&arg0.next_epoch_public_key)) {
            arg0.public_key = 0x1::option::extract<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&mut arg0.next_epoch_public_key);
        };
    }

    public(friend) fun set_deny_list_properties(arg0: &mut StorageNodeCap, arg1: u256, arg2: u64, arg3: u64) {
        arg0.deny_list_root = arg1;
        arg0.deny_list_sequence = arg2;
        arg0.deny_list_size = arg3;
    }

    public(friend) fun set_last_epoch_sync_done(arg0: &mut StorageNodeCap, arg1: u32) {
        arg0.last_epoch_sync_done = arg1;
    }

    public(friend) fun set_last_event_blob_attestation(arg0: &mut StorageNodeCap, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation) {
        arg0.last_event_blob_attestation = 0x1::option::some<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>(arg1);
    }

    public(friend) fun set_name(arg0: &mut StorageNodeInfo, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public(friend) fun set_network_address(arg0: &mut StorageNodeInfo, arg1: 0x1::string::String) {
        arg0.network_address = arg1;
    }

    public(friend) fun set_network_public_key(arg0: &mut StorageNodeInfo, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 33, 0);
        arg0.network_public_key = arg1;
    }

    public(friend) fun set_next_public_key(arg0: &mut StorageNodeInfo, arg1: vector<u8>) {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg1);
        0x1::option::swap_or_fill<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&mut arg0.next_epoch_public_key, 0x2::bls12381::g1_to_uncompressed_g1(&v0));
    }

    public(friend) fun set_node_metadata(arg0: &mut StorageNodeInfo, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata) {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::swap<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::node_metadata::NodeMetadata>(&mut arg0.metadata, arg1);
    }

    // decompiled from Move bytecode v6
}

