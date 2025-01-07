module 0x223644c7242f50004e0ca6b89b3d207efec9aeb848e88ce0a07225cdaf3e82ac::secure_storage {
    struct StorageInitiated has copy, drop {
        storage_id: 0x2::object::ID,
        initiator: address,
        supervisor: address,
        participant_limit: u64,
    }

    struct AssetDepositedEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        deposit_amount: u64,
    }

    struct ItemsStoredEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        item_count: u64,
        items_quota: u64,
    }

    struct AssetRetrievedEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        amount: u64,
    }

    struct ItemsRetrievedEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        count: u64,
    }

    struct AssetDistributedEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        beneficiary: address,
        processed_count: u64,
        pending_count: u64,
        amount: u64,
    }

    struct ItemsDistributedEvent<phantom T0> has copy, drop {
        storage_id: 0x2::object::ID,
        position: u64,
        beneficiary: address,
        processed_count: u64,
        pending_count: u64,
        quantity: u64,
    }

    struct ParticipantLimitUpdated has copy, drop {
        storage_id: 0x2::object::ID,
        previous_limit: u64,
        new_limit: u64,
    }

    struct StorageTerminated has copy, drop {
        by_initiator: bool,
        storage_id: 0x2::object::ID,
    }

    struct ItemContainer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        quota_per_participant: u64,
        items: vector<T0>,
    }

    struct SecureStorage has store, key {
        id: 0x2::object::UID,
        participant_limit: u64,
        distribution_count: u64,
        assets: 0x2::object_bag::ObjectBag,
        initiator: address,
        supervisor: address,
    }

    struct StorageSupervisor has store, key {
        id: 0x2::object::UID,
        admin: address,
        storages: 0x2::object_table::ObjectTable<0x2::object::ID, SecureStorage>,
    }

    public fun deposit_asset<T0>(arg0: &mut SecureStorage, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        verify_initiator(arg2, arg0);
        let v0 = 0x2::object_bag::length(&arg0.assets);
        let v1 = AssetDepositedEvent<T0>{
            storage_id     : 0x2::object::id<SecureStorage>(arg0),
            position       : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<AssetDepositedEvent<T0>>(v1);
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.assets, v0, arg1);
    }

    public fun distribute_asset<T0>(arg0: &mut SecureStorage, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_supervisor(arg3, arg0);
        let v0 = arg0.participant_limit - arg0.distribution_count;
        let v1 = if (v0 == 1) {
            let v2 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.assets, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg2);
            0x2::coin::value<T0>(&v2)
        } else {
            let v3 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.assets, arg1);
            let v4 = 0x2::coin::value<T0>(v3) / v0;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, v4, arg3), arg2);
            v4
        };
        let v5 = AssetDistributedEvent<T0>{
            storage_id      : 0x2::object::id<SecureStorage>(arg0),
            position        : arg1,
            beneficiary     : arg2,
            processed_count : arg0.distribution_count,
            pending_count   : v0,
            amount          : v1,
        };
        0x2::event::emit<AssetDistributedEvent<T0>>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        setup_storage_supervisor(arg0);
    }

    public fun initialize_storage(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SecureStorage {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = SecureStorage{
            id                 : v1,
            participant_limit  : arg1,
            distribution_count : 0,
            assets             : 0x2::object_bag::new(arg2),
            initiator          : v0,
            supervisor         : arg0,
        };
        let v3 = StorageInitiated{
            storage_id        : 0x2::object::uid_to_inner(&v1),
            initiator         : v0,
            supervisor        : arg0,
            participant_limit : arg1,
        };
        0x2::event::emit<StorageInitiated>(v3);
        v2
    }

    public fun setup_storage_supervisor(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageSupervisor{
            id       : 0x2::object::new(arg0),
            admin    : @0x518a3d64516564dbc54bd1363985b502b4860f0a28a5b7ab531a1e1bc94604d9,
            storages : 0x2::object_table::new<0x2::object::ID, SecureStorage>(arg0),
        };
        0x2::transfer::share_object<StorageSupervisor>(v0);
    }

    public fun store_items<T0: store + key>(arg0: &mut SecureStorage, arg1: u64, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_initiator(arg3, arg0);
        let v0 = 0x1::vector::length<T0>(&arg2);
        assert!(v0 < arg1 * arg0.participant_limit, 4);
        let v1 = 0x2::object_bag::length(&arg0.assets);
        let v2 = ItemContainer<T0>{
            id                    : 0x2::object::new(arg3),
            quota_per_participant : arg1,
            items                 : arg2,
        };
        0x2::object_bag::add<u64, ItemContainer<T0>>(&mut arg0.assets, v1, v2);
        let v3 = ItemsStoredEvent<T0>{
            storage_id  : 0x2::object::id<SecureStorage>(arg0),
            position    : v1,
            item_count  : v0,
            items_quota : arg1,
        };
        0x2::event::emit<ItemsStoredEvent<T0>>(v3);
    }

    fun verify_initiator(arg0: &0x2::tx_context::TxContext, arg1: &SecureStorage) {
        assert!(0x2::tx_context::sender(arg0) == arg1.initiator, 1);
    }

    fun verify_supervisor(arg0: &0x2::tx_context::TxContext, arg1: &SecureStorage) {
        assert!(0x2::tx_context::sender(arg0) == arg1.supervisor, 2);
    }

    // decompiled from Move bytecode v6
}

