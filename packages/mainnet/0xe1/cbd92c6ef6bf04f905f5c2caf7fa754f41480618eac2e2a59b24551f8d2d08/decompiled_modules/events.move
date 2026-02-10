module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events {
    struct BlobRegistered has copy, drop {
        epoch: u32,
        blob_id: u256,
        size: u64,
        encoding_type: u8,
        end_epoch: u32,
        deletable: bool,
        object_id: 0x2::object::ID,
    }

    struct BlobCertified has copy, drop {
        epoch: u32,
        blob_id: u256,
        end_epoch: u32,
        deletable: bool,
        object_id: 0x2::object::ID,
        is_extension: bool,
    }

    struct BlobDeleted has copy, drop {
        epoch: u32,
        blob_id: u256,
        end_epoch: u32,
        object_id: 0x2::object::ID,
        was_certified: bool,
    }

    struct InvalidBlobID has copy, drop {
        epoch: u32,
        blob_id: u256,
    }

    struct EpochChangeStart has copy, drop {
        epoch: u32,
    }

    struct EpochChangeDone has copy, drop {
        epoch: u32,
    }

    struct ShardsReceived has copy, drop {
        epoch: u32,
        shards: vector<u16>,
    }

    struct EpochParametersSelected has copy, drop {
        next_epoch: u32,
    }

    struct ShardRecoveryStart has copy, drop {
        epoch: u32,
        shards: vector<u16>,
    }

    struct ContractUpgraded has copy, drop {
        epoch: u32,
        package_id: 0x2::object::ID,
        version: u64,
    }

    struct RegisterDenyListUpdate has copy, drop {
        epoch: u32,
        root: u256,
        sequence_number: u64,
        node_id: 0x2::object::ID,
    }

    struct DenyListUpdate has copy, drop {
        epoch: u32,
        root: u256,
        sequence_number: u64,
        node_id: 0x2::object::ID,
    }

    struct DenyListBlobDeleted has copy, drop {
        epoch: u32,
        blob_id: u256,
    }

    struct ContractUpgradeProposed has copy, drop {
        epoch: u32,
        package_digest: vector<u8>,
    }

    struct ContractUpgradeQuorumReached has copy, drop {
        epoch: u32,
        package_digest: vector<u8>,
    }

    struct ProtocolVersionUpdated has copy, drop {
        epoch: u32,
        start_epoch: u32,
        protocol_version: u64,
    }

    public(friend) fun emit_blob_certified(arg0: u32, arg1: u256, arg2: u32, arg3: bool, arg4: 0x2::object::ID, arg5: bool) {
        let v0 = BlobCertified{
            epoch        : arg0,
            blob_id      : arg1,
            end_epoch    : arg2,
            deletable    : arg3,
            object_id    : arg4,
            is_extension : arg5,
        };
        0x2::event::emit<BlobCertified>(v0);
    }

    public(friend) fun emit_blob_deleted(arg0: u32, arg1: u256, arg2: u32, arg3: 0x2::object::ID, arg4: bool) {
        let v0 = BlobDeleted{
            epoch         : arg0,
            blob_id       : arg1,
            end_epoch     : arg2,
            object_id     : arg3,
            was_certified : arg4,
        };
        0x2::event::emit<BlobDeleted>(v0);
    }

    public(friend) fun emit_blob_registered(arg0: u32, arg1: u256, arg2: u64, arg3: u8, arg4: u32, arg5: bool, arg6: 0x2::object::ID) {
        let v0 = BlobRegistered{
            epoch         : arg0,
            blob_id       : arg1,
            size          : arg2,
            encoding_type : arg3,
            end_epoch     : arg4,
            deletable     : arg5,
            object_id     : arg6,
        };
        0x2::event::emit<BlobRegistered>(v0);
    }

    public(friend) fun emit_contract_upgrade_proposed(arg0: u32, arg1: vector<u8>) {
        let v0 = ContractUpgradeProposed{
            epoch          : arg0,
            package_digest : arg1,
        };
        0x2::event::emit<ContractUpgradeProposed>(v0);
    }

    public(friend) fun emit_contract_upgrade_quorum_reached(arg0: u32, arg1: vector<u8>) {
        let v0 = ContractUpgradeQuorumReached{
            epoch          : arg0,
            package_digest : arg1,
        };
        0x2::event::emit<ContractUpgradeQuorumReached>(v0);
    }

    public(friend) fun emit_contract_upgraded(arg0: u32, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ContractUpgraded{
            epoch      : arg0,
            package_id : arg1,
            version    : arg2,
        };
        0x2::event::emit<ContractUpgraded>(v0);
    }

    public(friend) fun emit_deny_list_update(arg0: u32, arg1: u256, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = DenyListUpdate{
            epoch           : arg0,
            root            : arg1,
            sequence_number : arg2,
            node_id         : arg3,
        };
        0x2::event::emit<DenyListUpdate>(v0);
    }

    public(friend) fun emit_deny_listed_blob_deleted(arg0: u32, arg1: u256) {
        let v0 = DenyListBlobDeleted{
            epoch   : arg0,
            blob_id : arg1,
        };
        0x2::event::emit<DenyListBlobDeleted>(v0);
    }

    public(friend) fun emit_epoch_change_done(arg0: u32) {
        let v0 = EpochChangeDone{epoch: arg0};
        0x2::event::emit<EpochChangeDone>(v0);
    }

    public(friend) fun emit_epoch_change_start(arg0: u32) {
        let v0 = EpochChangeStart{epoch: arg0};
        0x2::event::emit<EpochChangeStart>(v0);
    }

    public(friend) fun emit_epoch_parameters_selected(arg0: u32) {
        let v0 = EpochParametersSelected{next_epoch: arg0};
        0x2::event::emit<EpochParametersSelected>(v0);
    }

    public(friend) fun emit_invalid_blob_id(arg0: u32, arg1: u256) {
        let v0 = InvalidBlobID{
            epoch   : arg0,
            blob_id : arg1,
        };
        0x2::event::emit<InvalidBlobID>(v0);
    }

    public(friend) fun emit_protocol_version(arg0: u32, arg1: u32, arg2: u64) {
        let v0 = ProtocolVersionUpdated{
            epoch            : arg0,
            start_epoch      : arg1,
            protocol_version : arg2,
        };
        0x2::event::emit<ProtocolVersionUpdated>(v0);
    }

    public(friend) fun emit_register_deny_list_update(arg0: u32, arg1: u256, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = RegisterDenyListUpdate{
            epoch           : arg0,
            root            : arg1,
            sequence_number : arg2,
            node_id         : arg3,
        };
        0x2::event::emit<RegisterDenyListUpdate>(v0);
    }

    public(friend) fun emit_shard_recovery_start(arg0: u32, arg1: vector<u16>) {
        let v0 = ShardRecoveryStart{
            epoch  : arg0,
            shards : arg1,
        };
        0x2::event::emit<ShardRecoveryStart>(v0);
    }

    public(friend) fun emit_shards_received(arg0: u32, arg1: vector<u16>) {
        let v0 = ShardsReceived{
            epoch  : arg0,
            shards : arg1,
        };
        0x2::event::emit<ShardsReceived>(v0);
    }

    // decompiled from Move bytecode v6
}

