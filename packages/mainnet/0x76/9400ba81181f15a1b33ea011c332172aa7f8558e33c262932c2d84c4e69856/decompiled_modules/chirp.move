module 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::chirp {
    struct CHIRP has drop {
        dummy_field: bool,
    }

    struct ScheduleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VestingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object_bag::ObjectBag,
        version: u64,
    }

    entry fun claim(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = depository(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x2::object_table::contains<address, 0x2::coin::Coin<CHIRP>>(v0, v1)) {
            let v3 = 0x2::object_table::borrow_mut<address, 0x2::coin::Coin<CHIRP>>(v0, v1);
            0x2::coin::split<CHIRP>(v3, 0x1::u64::min(arg1, 0x2::coin::value<CHIRP>(v3)), arg2)
        } else {
            0x2::coin::zero<CHIRP>(arg2)
        };
        let v4 = v2;
        let v5 = arg1 - 0x2::coin::value<CHIRP>(&v4);
        if (v5 > 0) {
            let v6 = treasury(arg0);
            let v7 = 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::current_epoch<CHIRP>(v6);
            let v8 = vesting_ledger(arg0);
            let (v9, v10) = 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::claim<CHIRP>(v8, v1, v5, v7, arg2);
            0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::transfer<CHIRP>(pool_dispatcher(arg0), 0x1::string::utf8(b"lockup"), v10);
            0x2::coin::join<CHIRP>(&mut v4, v9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIRP>>(v4, v1);
    }

    public fun deposit_batch(arg0: &mut Vault, arg1: vector<0x2::coin::Coin<CHIRP>>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<CHIRP>>(&mut arg1);
        0x2::pay::join_vec<CHIRP>(&mut v0, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::coin::split<CHIRP>(&mut v0, 0x1::vector::pop_back<u64>(&mut arg3), arg4);
            let v3 = depository(arg0);
            if (!0x2::object_table::contains<address, 0x2::coin::Coin<CHIRP>>(v3, v1)) {
                0x2::object_table::add<address, 0x2::coin::Coin<CHIRP>>(v3, v1, v2);
                continue
            };
            0x2::coin::join<CHIRP>(0x2::object_table::borrow_mut<address, 0x2::coin::Coin<CHIRP>>(v3, v1), v2);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIRP>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun depository(arg0: &mut Vault) : &mut 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<CHIRP>> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<CHIRP>>>(&mut arg0.registry, 0x1::string::utf8(b"depository"))
    }

    fun init(arg0: CHIRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRP>(arg0, 10, b"CHIRP", b"Chirp Token", x"43484952503a20546865206e617469766520746f6b656e206f66204368697270e280997320446550494e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://download.chirpwireless.io/images/CHIRP_White_OBG.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRP>>(v1);
        let v2 = Vault{
            id       : 0x2::object::new(arg1),
            registry : 0x2::object_bag::new(arg1),
            version  : 2,
        };
        0x2::object_bag::add<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::PoolDispatcher>(&mut v2.registry, 0x1::string::utf8(b"pool_dispatcher"), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::default(arg1));
        0x2::object_bag::add<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::Treasury<CHIRP>>(&mut v2.registry, 0x1::string::utf8(b"treasury"), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::create<CHIRP>(v0, 3000000000000000000, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::schedule::default<CHIRP>(), arg1));
        0x2::object_bag::add<0x1::string::String, 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<CHIRP>>>(&mut v2.registry, 0x1::string::utf8(b"depository"), 0x2::object_table::new<address, 0x2::coin::Coin<CHIRP>>(arg1));
        0x2::object_bag::add<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::VestingLedger<CHIRP>>(&mut v2.registry, 0x1::string::utf8(b"vesting_ledger"), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::create<CHIRP>(45, 6000000000, arg1));
        let v3 = &mut v2;
        premint(v3, arg1);
        let v4 = ScheduleAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ScheduleAdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = VestingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VestingAdminCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Vault>(v2);
    }

    public fun insert_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.version == 2, 2);
        let v0 = pool_dispatcher(arg1);
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::insert_entry<CHIRP>(treasury(arg1), arg2, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::create_entry<CHIRP>(arg3, arg4, arg5, arg6, arg7));
    }

    public fun lock_batch(arg0: &mut Vault, arg1: vector<0x2::coin::Coin<CHIRP>>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = treasury(arg0);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<CHIRP>>(&mut arg1);
        0x2::pay::join_vec<CHIRP>(&mut v1, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::lock<CHIRP>(vesting_ledger(arg0), 0x1::vector::pop_back<address>(&mut arg2), 0x2::coin::split<CHIRP>(&mut v1, 0x1::vector::pop_back<u64>(&mut arg3), arg4), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::current_epoch<CHIRP>(v0), arg4);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIRP>>(v1, 0x2::tx_context::sender(arg4));
    }

    entry fun migrate(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 2, 1);
        if (arg1.version == 1) {
            0x2::object_bag::add<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::VestingLedger<CHIRP>>(&mut arg1.registry, 0x1::string::utf8(b"vesting_ledger"), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::create<CHIRP>(45, 6000000000, arg2));
            let v0 = pool_dispatcher(arg1);
            0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::add_address_pool(v0, 0x1::string::utf8(b"lockup"), @0xa65694ba9f7bc5370e532c9616d0a720d9843975fb55d21848ced91051a1ec03);
            let v1 = VestingAdminCap{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<VestingAdminCap>(v1, 0x2::tx_context::sender(arg2));
            arg1.version = arg1.version + 1;
        };
        arg1.version = 2;
    }

    public fun mint(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = treasury(arg0);
        let (v1, v2) = 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::mint<CHIRP>(v0, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = pool_dispatcher(arg0);
        while (!0x1::vector::is_empty<0x1::string::String>(&v4)) {
            0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::transfer<CHIRP>(v5, 0x1::vector::pop_back<0x1::string::String>(&mut v4), 0x1::vector::pop_back<0x2::coin::Coin<CHIRP>>(&mut v3));
        };
        0x1::vector::destroy_empty<0x1::string::String>(v4);
        0x1::vector::destroy_empty<0x2::coin::Coin<CHIRP>>(v3);
    }

    fun pool_dispatcher(arg0: &mut Vault) : &mut 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::PoolDispatcher {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::PoolDispatcher>(&mut arg0.registry, 0x1::string::utf8(b"pool_dispatcher"))
    }

    fun premint(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = treasury(arg0);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::transfer<CHIRP>(pool_dispatcher(arg0), 0x1::string::utf8(b"liquidity"), 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::premint<CHIRP>(v0, 150000000000000000, arg1));
    }

    public fun remove_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg1.version == 2, 2);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::remove_entry<CHIRP>(treasury(arg1), arg2);
    }

    public fun set_address_pool(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: 0x1::string::String, arg3: address) {
        assert!(arg1.version == 2, 2);
        let v0 = pool_dispatcher(arg1);
        assert!(0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::contains(v0, arg2), 3);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::set_address_pool(v0, arg2, arg3);
    }

    public fun set_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.version == 2, 2);
        let v0 = pool_dispatcher(arg1);
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::set_entry<CHIRP>(treasury(arg1), arg2, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::create_entry<CHIRP>(arg3, arg4, arg5, arg6, arg7));
    }

    public fun set_vesting_penalty(arg0: &VestingAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg2 <= 10000000000, 4);
        assert!(arg1.version == 2, 2);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::set_initial_penalty<CHIRP>(vesting_ledger(arg1), arg2);
    }

    public fun set_vesting_period(arg0: &VestingAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg2 <= 1800, 4);
        assert!(arg1.version == 2, 2);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::set_vesting_period<CHIRP>(vesting_ledger(arg1), arg2);
    }

    fun treasury(arg0: &mut Vault) : &mut 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::Treasury<CHIRP> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::Treasury<CHIRP>>(&mut arg0.registry, 0x1::string::utf8(b"treasury"))
    }

    entry fun unblock_minting(arg0: &ScheduleAdminCap, arg1: &mut Vault) {
        assert!(arg1.version == 2, 2);
        0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::treasury::unblock_minting<CHIRP>(treasury(arg1));
    }

    fun vesting_ledger(arg0: &mut Vault) : &mut 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::VestingLedger<CHIRP> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger::VestingLedger<CHIRP>>(&mut arg0.registry, 0x1::string::utf8(b"vesting_ledger"))
    }

    // decompiled from Move bytecode v6
}

