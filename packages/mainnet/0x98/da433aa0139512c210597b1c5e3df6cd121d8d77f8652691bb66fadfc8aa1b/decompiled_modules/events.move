module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::events {
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

    struct PricesUpdated has copy, drop {
        epoch: u32,
        storage_price: u64,
        write_price: u64,
    }

    struct StoragePoolCreated has copy, drop {
        epoch: u32,
        storage_pool_id: 0x2::object::ID,
        reserved_encoded_capacity_bytes: u64,
        start_epoch: u32,
        end_epoch: u32,
    }

    struct PooledBlobRegistered has copy, drop {
        epoch: u32,
        blob_id: u256,
        unencoded_size: u64,
        encoding_type: u8,
        deletable: bool,
        object_id: 0x2::object::ID,
        storage_pool_id: 0x2::object::ID,
    }

    struct PooledBlobCertified has copy, drop {
        epoch: u32,
        blob_id: u256,
        deletable: bool,
        object_id: 0x2::object::ID,
        storage_pool_id: 0x2::object::ID,
    }

    struct PooledBlobDeleted has copy, drop {
        epoch: u32,
        blob_id: u256,
        object_id: 0x2::object::ID,
        was_certified: bool,
        storage_pool_id: 0x2::object::ID,
    }

    struct StoragePoolExtended has copy, drop {
        epoch: u32,
        storage_pool_id: 0x2::object::ID,
        new_end_epoch: u32,
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

    public(friend) fun emit_pooled_blob_certified(arg0: u32, arg1: u256, arg2: bool, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        let v0 = PooledBlobCertified{
            epoch           : arg0,
            blob_id         : arg1,
            deletable       : arg2,
            object_id       : arg3,
            storage_pool_id : arg4,
        };
        0x2::event::emit<PooledBlobCertified>(v0);
    }

    public(friend) fun emit_pooled_blob_deleted(arg0: u32, arg1: u256, arg2: 0x2::object::ID, arg3: bool, arg4: 0x2::object::ID) {
        let v0 = PooledBlobDeleted{
            epoch           : arg0,
            blob_id         : arg1,
            object_id       : arg2,
            was_certified   : arg3,
            storage_pool_id : arg4,
        };
        0x2::event::emit<PooledBlobDeleted>(v0);
    }

    public(friend) fun emit_pooled_blob_registered(arg0: u32, arg1: u256, arg2: u64, arg3: u8, arg4: bool, arg5: 0x2::object::ID, arg6: 0x2::object::ID) {
        let v0 = PooledBlobRegistered{
            epoch           : arg0,
            blob_id         : arg1,
            unencoded_size  : arg2,
            encoding_type   : arg3,
            deletable       : arg4,
            object_id       : arg5,
            storage_pool_id : arg6,
        };
        0x2::event::emit<PooledBlobRegistered>(v0);
    }

    public(friend) fun emit_prices_updated(arg0: u32, arg1: u64, arg2: u64) {
        let v0 = PricesUpdated{
            epoch         : arg0,
            storage_price : arg1,
            write_price   : arg2,
        };
        0x2::event::emit<PricesUpdated>(v0);
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

    public(friend) fun emit_storage_pool_created(arg0: u32, arg1: 0x2::object::ID, arg2: u64, arg3: u32, arg4: u32) {
        let v0 = StoragePoolCreated{
            epoch                           : arg0,
            storage_pool_id                 : arg1,
            reserved_encoded_capacity_bytes : arg2,
            start_epoch                     : arg3,
            end_epoch                       : arg4,
        };
        0x2::event::emit<StoragePoolCreated>(v0);
    }

    public(friend) fun emit_storage_pool_extended(arg0: u32, arg1: 0x2::object::ID, arg2: u32) {
        let v0 = StoragePoolExtended{
            epoch           : arg0,
            storage_pool_id : arg1,
            new_end_epoch   : arg2,
        };
        0x2::event::emit<StoragePoolExtended>(v0);
    }

    // decompiled from Move bytecode v7
}

