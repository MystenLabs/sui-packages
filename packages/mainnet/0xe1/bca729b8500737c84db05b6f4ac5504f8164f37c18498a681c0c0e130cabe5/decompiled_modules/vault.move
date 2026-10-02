module 0x1e8f75487cc37e1a6dbfa3fed6d55187761e5de88fbf71432278cd6afbe09eb4::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        devices: 0x2::vec_set::VecSet<address>,
        header: vector<u8>,
        header_revision: u64,
        revision: u64,
        item_count: u64,
    }

    struct ItemKey has copy, drop, store {
        id: vector<u8>,
    }

    struct Item has drop, store {
        revision: u64,
        data: vector<u8>,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
    }

    struct ItemChanged has copy, drop {
        vault: 0x2::object::ID,
        item: vector<u8>,
        revision: u64,
        deleted: bool,
        by: address,
    }

    struct HeaderChanged has copy, drop {
        vault: 0x2::object::ID,
        header_revision: u64,
        by: address,
    }

    struct DeviceChanged has copy, drop {
        vault: 0x2::object::ID,
        device: address,
        added: bool,
    }

    struct Recoveries has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<0x2::object::ID, Recovery>,
    }

    struct Recovery has store {
        public_key: vector<u8>,
        delay_ms: u64,
        nonce: u64,
        request: 0x1::option::Option<RecoveryRequest>,
    }

    struct RecoveryRequest has copy, drop, store {
        new_owner: address,
        requested_ms: u64,
        ready_ms: u64,
    }

    struct RecoverySet has copy, drop {
        vault: 0x2::object::ID,
        delay_ms: u64,
    }

    struct RecoveryRequested has copy, drop {
        vault: 0x2::object::ID,
        new_owner: address,
        ready_ms: u64,
    }

    struct RecoveryCancelled has copy, drop {
        vault: 0x2::object::ID,
        by: address,
    }

    struct RecoveryCompleted has copy, drop {
        vault: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public fun add_device(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg0.devices, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.devices, arg1);
        };
        let v0 = DeviceChanged{
            vault  : 0x2::object::id<Vault>(arg0),
            device : arg1,
            added  : true,
        };
        0x2::event::emit<DeviceChanged>(v0);
    }

    fun assert_device(arg0: &Vault, arg1: address) {
        assert!(arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.devices, &arg1), 1);
    }

    fun assert_owner(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun cancel_recovery(arg0: &mut Recoveries, arg1: &Vault, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.vaults, v0), 7);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.vaults, v0);
        assert!(0x1::option::is_some<RecoveryRequest>(&v1.request), 10);
        assert!(0x2::tx_context::sender(arg2) == arg1.owner || 0x2::tx_context::sender(arg2) == 0x1::option::borrow<RecoveryRequest>(&v1.request).new_owner, 0);
        v1.request = 0x1::option::none<RecoveryRequest>();
        let v2 = RecoveryCancelled{
            vault : v0,
            by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RecoveryCancelled>(v2);
    }

    fun check_header(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0 && 0x1::vector::length<u8>(arg0) <= 2048, 5);
    }

    public fun complete_recovery(arg0: &mut Recoveries, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.vaults, v0), 7);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.vaults, v0);
        assert!(0x1::option::is_some<RecoveryRequest>(&v1.request), 10);
        let v2 = *0x1::option::borrow<RecoveryRequest>(&v1.request);
        assert!(0x2::tx_context::sender(arg3) == v2.new_owner, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.ready_ms, 11);
        v1.request = 0x1::option::none<RecoveryRequest>();
        let v3 = arg1.owner;
        if (0x2::vec_set::contains<address>(&arg1.devices, &v3)) {
            0x2::vec_set::remove<address>(&mut arg1.devices, &v3);
        };
        if (!0x2::vec_set::contains<address>(&arg1.devices, &v2.new_owner)) {
            0x2::vec_set::insert<address>(&mut arg1.devices, v2.new_owner);
        };
        arg1.owner = v2.new_owner;
        let v4 = DeviceChanged{
            vault  : v0,
            device : v3,
            added  : false,
        };
        0x2::event::emit<DeviceChanged>(v4);
        let v5 = RecoveryCompleted{
            vault     : v0,
            old_owner : v3,
            new_owner : v2.new_owner,
        };
        0x2::event::emit<RecoveryCompleted>(v5);
    }

    public fun create_recoveries(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Recoveries{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::table::new<0x2::object::ID, Recovery>(arg0),
        };
        0x2::transfer::share_object<Recoveries>(v0);
    }

    public fun create_vault(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        share_vault(new_vault(arg0, arg1));
    }

    public fun delete_item(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg3));
        let v0 = ItemKey{id: arg1};
        assert!(0x2::dynamic_field::exists<ItemKey>(&arg0.id, v0), 6);
        let Item {
            revision : v1,
            data     : _,
        } = 0x2::dynamic_field::remove<ItemKey, Item>(&mut arg0.id, v0);
        assert!(v1 == arg2, 2);
        arg0.revision = arg0.revision + 1;
        arg0.item_count = arg0.item_count - 1;
        let v3 = ItemChanged{
            vault    : 0x2::object::id<Vault>(arg0),
            item     : arg1,
            revision : arg0.revision,
            deleted  : true,
            by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemChanged>(v3);
    }

    public fun header_revision(arg0: &Vault) : u64 {
        arg0.header_revision
    }

    public fun is_device(arg0: &Vault, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.devices, &arg1)
    }

    public fun item_count(arg0: &Vault) : u64 {
        arg0.item_count
    }

    public fun item_revision(arg0: &Vault, arg1: vector<u8>) : u64 {
        let v0 = ItemKey{id: arg1};
        if (!0x2::dynamic_field::exists<ItemKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<ItemKey, Item>(&arg0.id, v0).revision
    }

    public fun new_vault(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Vault {
        check_header(&arg0);
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg1));
        let v1 = Vault{
            id              : 0x2::object::new(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            devices         : v0,
            header          : arg0,
            header_revision : 1,
            revision        : 0,
            item_count      : 0,
        };
        let v2 = VaultCreated{
            vault : 0x2::object::id<Vault>(&v1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultCreated>(v2);
        v1
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun put_item(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x1::vector::length<u8>(&arg1) == 16, 4);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 15000, 3);
        let v0 = ItemKey{id: arg1};
        arg0.revision = arg0.revision + 1;
        let v1 = arg0.revision;
        if (0x2::dynamic_field::exists<ItemKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<ItemKey, Item>(&mut arg0.id, v0);
            assert!(v2.revision == arg2, 2);
            v2.revision = v1;
            v2.data = arg3;
        } else {
            assert!(arg2 == 0, 2);
            let v3 = Item{
                revision : v1,
                data     : arg3,
            };
            0x2::dynamic_field::add<ItemKey, Item>(&mut arg0.id, v0, v3);
            arg0.item_count = arg0.item_count + 1;
        };
        let v4 = ItemChanged{
            vault    : 0x2::object::id<Vault>(arg0),
            item     : arg1,
            revision : v1,
            deleted  : false,
            by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ItemChanged>(v4);
    }

    public fun recovery_message(arg0: 0x2::object::ID, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"suipass-recovery-v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun remove_device(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        if (0x2::vec_set::contains<address>(&arg0.devices, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.devices, &arg1);
        };
        let v0 = DeviceChanged{
            vault  : 0x2::object::id<Vault>(arg0),
            device : arg1,
            added  : false,
        };
        0x2::event::emit<DeviceChanged>(v0);
    }

    public fun request_recovery(arg0: &mut Recoveries, arg1: &Vault, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Recovery>(&arg0.vaults, v0), 7);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.vaults, v0);
        assert!(0x1::option::is_none<RecoveryRequest>(&v1.request), 8);
        let v2 = recovery_message(v0, 0x2::tx_context::sender(arg4), v1.nonce);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v1.public_key, &v2), 9);
        start_request(v1, v0, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3));
    }

    public fun revision(arg0: &Vault) : u64 {
        arg0.revision
    }

    public fun set_header(arg0: &mut Vault, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_device(arg0, 0x2::tx_context::sender(arg3));
        check_header(&arg2);
        assert!(arg0.header_revision == arg1, 2);
        arg0.header = arg2;
        arg0.header_revision = arg0.header_revision + 1;
        arg0.revision = arg0.revision + 1;
        let v0 = HeaderChanged{
            vault           : 0x2::object::id<Vault>(arg0),
            header_revision : arg0.header_revision,
            by              : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<HeaderChanged>(v0);
    }

    public fun set_recovery(arg0: &mut Recoveries, arg1: &Vault, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg4);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 12);
        assert!(arg3 >= 60000 && arg3 <= 2592000000, 13);
        let v0 = 0x2::object::id<Vault>(arg1);
        if (0x2::table::contains<0x2::object::ID, Recovery>(&arg0.vaults, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, Recovery>(&mut arg0.vaults, v0);
            v1.public_key = arg2;
            v1.delay_ms = arg3;
        } else {
            let v2 = Recovery{
                public_key : arg2,
                delay_ms   : arg3,
                nonce      : 0,
                request    : 0x1::option::none<RecoveryRequest>(),
            };
            0x2::table::add<0x2::object::ID, Recovery>(&mut arg0.vaults, v0, v2);
        };
        let v3 = RecoverySet{
            vault    : v0,
            delay_ms : arg3,
        };
        0x2::event::emit<RecoverySet>(v3);
    }

    public fun share_vault(arg0: Vault) {
        0x2::transfer::share_object<Vault>(arg0);
    }

    fun start_request(arg0: &mut Recovery, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        arg0.nonce = arg0.nonce + 1;
        let v0 = arg3 + arg0.delay_ms;
        let v1 = RecoveryRequest{
            new_owner    : arg2,
            requested_ms : arg3,
            ready_ms     : v0,
        };
        arg0.request = 0x1::option::some<RecoveryRequest>(v1);
        let v2 = RecoveryRequested{
            vault     : arg1,
            new_owner : arg2,
            ready_ms  : v0,
        };
        0x2::event::emit<RecoveryRequested>(v2);
    }

    public fun transfer_owner(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v7
}

