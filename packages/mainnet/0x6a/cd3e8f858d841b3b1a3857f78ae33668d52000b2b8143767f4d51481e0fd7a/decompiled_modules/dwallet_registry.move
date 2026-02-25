module 0x6acd3e8f858d841b3b1a3857f78ae33668d52000b2b8143767f4d51481e0fd7a::dwallet_registry {
    struct DWalletRegistered has copy, drop {
        deposit_address: vector<u8>,
        dwallet_id: vector<u8>,
        owner: address,
        timestamp: u64,
    }

    struct DWalletUnregistered has copy, drop {
        deposit_address: vector<u8>,
        timestamp: u64,
    }

    struct DWalletReactivated has copy, drop {
        deposit_address: vector<u8>,
        timestamp: u64,
    }

    struct OwnershipTransferred has copy, drop {
        old_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    struct DWalletUsed has copy, drop {
        deposit_address: vector<u8>,
        timestamp: u64,
    }

    struct DWalletRecord has copy, drop, store {
        deposit_address: vector<u8>,
        dwallet_id: vector<u8>,
        dwallet_pubkey: vector<u8>,
        owner: address,
        registered_at: u64,
        active: bool,
        used: bool,
    }

    struct RegistryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct DWalletRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        wallets: 0x2::table::Table<vector<u8>, DWalletRecord>,
        dwallet_caps: 0x2::table::Table<vector<u8>, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        dwallet_ids: 0x2::table::Table<vector<u8>, vector<u8>>,
        total_registered: u64,
        total_active: u64,
    }

    public fun address_to_bytes(arg0: address) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0)
    }

    public fun get_deposit_address(arg0: &DWalletRegistry, arg1: &vector<u8>) : vector<u8> {
        assert!(0x2::table::contains<vector<u8>, vector<u8>>(&arg0.dwallet_ids, *arg1), 1);
        *0x2::table::borrow<vector<u8>, vector<u8>>(&arg0.dwallet_ids, *arg1)
    }

    public fun get_dwallet_id(arg0: &DWalletRegistry, arg1: &vector<u8>) : vector<u8> {
        0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1).dwallet_id
    }

    public fun get_dwallet_pubkey(arg0: &DWalletRegistry, arg1: &vector<u8>) : vector<u8> {
        0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1).dwallet_pubkey
    }

    public fun get_owner(arg0: &DWalletRegistry, arg1: &vector<u8>) : address {
        0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1).owner
    }

    public fun get_owner_address(arg0: &DWalletRegistry) : address {
        arg0.owner
    }

    public fun get_record(arg0: &DWalletRegistry, arg1: &vector<u8>) : DWalletRecord {
        assert!(0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1), 1);
        *0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1)
    }

    public fun has_dwallet_cap(arg0: &DWalletRegistry, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.dwallet_caps, *arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = RegistryOwnerCap{id: 0x2::object::new(arg0)};
        let v2 = DWalletRegistry{
            id               : 0x2::object::new(arg0),
            owner            : v0,
            wallets          : 0x2::table::new<vector<u8>, DWalletRecord>(arg0),
            dwallet_caps     : 0x2::table::new<vector<u8>, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg0),
            dwallet_ids      : 0x2::table::new<vector<u8>, vector<u8>>(arg0),
            total_registered : 0,
            total_active     : 0,
        };
        0x2::transfer::share_object<DWalletRegistry>(v2);
        0x2::transfer::public_transfer<RegistryOwnerCap>(v1, v0);
    }

    public fun is_dwallet_registered(arg0: &DWalletRegistry, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, vector<u8>>(&arg0.dwallet_ids, *arg1)
    }

    public fun is_dwallet_used(arg0: &DWalletRegistry, arg1: &vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1).used
    }

    public fun is_owner(arg0: &DWalletRegistry, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public fun is_registered(arg0: &DWalletRegistry, arg1: &vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1).active
    }

    public(friend) fun mark_dwallet_used(arg0: &mut DWalletRegistry, arg1: &vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, *arg1), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, DWalletRecord>(&mut arg0.wallets, *arg1);
        assert!(!v0.used, 6);
        if (v0.active) {
            arg0.total_active = arg0.total_active - 1;
        };
        v0.used = true;
        v0.active = false;
        let v1 = DWalletUsed{
            deposit_address : *arg1,
            timestamp       : 0,
        };
        0x2::event::emit<DWalletUsed>(v1);
    }

    public fun reactivate_dwallet(arg0: &mut DWalletRegistry, arg1: &RegistryOwnerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, arg2), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, DWalletRecord>(&mut arg0.wallets, arg2);
        assert!(!v0.active, 5);
        v0.active = true;
        arg0.total_active = arg0.total_active + 1;
        let v1 = DWalletReactivated{
            deposit_address : arg2,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DWalletReactivated>(v1);
    }

    public fun record_active(arg0: &DWalletRecord) : bool {
        arg0.active
    }

    public fun record_deposit_address(arg0: &DWalletRecord) : &vector<u8> {
        &arg0.deposit_address
    }

    public fun record_dwallet_id(arg0: &DWalletRecord) : &vector<u8> {
        &arg0.dwallet_id
    }

    public fun record_owner(arg0: &DWalletRecord) : address {
        arg0.owner
    }

    public fun record_registered_at(arg0: &DWalletRecord) : u64 {
        arg0.registered_at
    }

    public fun record_used(arg0: &DWalletRecord) : bool {
        arg0.used
    }

    public fun register_dwallet(arg0: &mut DWalletRegistry, arg1: &RegistryOwnerCap, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 == 20 || v0 == 32, 4);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v1 == 32 || v1 == 33, 4);
        assert!(!0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, arg2), 2);
        let v2 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg4);
        let v3 = 0x2::object::id_to_bytes(&v2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = 0x2::tx_context::epoch(arg5);
        let v6 = DWalletRecord{
            deposit_address : arg2,
            dwallet_id      : v3,
            dwallet_pubkey  : arg3,
            owner           : v4,
            registered_at   : v5,
            active          : true,
            used            : false,
        };
        0x2::table::add<vector<u8>, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.dwallet_caps, arg2, arg4);
        0x2::table::add<vector<u8>, DWalletRecord>(&mut arg0.wallets, arg2, v6);
        0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.dwallet_ids, v3, arg2);
        arg0.total_registered = arg0.total_registered + 1;
        arg0.total_active = arg0.total_active + 1;
        let v7 = DWalletRegistered{
            deposit_address : arg2,
            dwallet_id      : v3,
            owner           : v4,
            timestamp       : v5,
        };
        0x2::event::emit<DWalletRegistered>(v7);
    }

    public fun total_active(arg0: &DWalletRegistry) : u64 {
        arg0.total_active
    }

    public fun total_registered(arg0: &DWalletRegistry) : u64 {
        arg0.total_registered
    }

    public fun transfer_ownership(arg0: &mut DWalletRegistry, arg1: &RegistryOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg2;
        let v0 = OwnershipTransferred{
            old_owner : arg0.owner,
            new_owner : arg2,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public fun unregister_dwallet(arg0: &mut DWalletRegistry, arg1: &RegistryOwnerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DWalletRecord>(&arg0.wallets, arg2), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, DWalletRecord>(&mut arg0.wallets, arg2);
        if (v0.active) {
            arg0.total_active = arg0.total_active - 1;
        };
        v0.active = false;
        let v1 = DWalletUnregistered{
            deposit_address : arg2,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DWalletUnregistered>(v1);
    }

    // decompiled from Move bytecode v6
}

