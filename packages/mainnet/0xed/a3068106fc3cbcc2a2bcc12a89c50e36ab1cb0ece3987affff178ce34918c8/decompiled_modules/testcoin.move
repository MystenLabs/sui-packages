module 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::testcoin {
    struct TESTCOIN has drop {
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

    fun pool_dispatcher(arg0: &mut Vault) : &mut 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::PoolDispatcher {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::PoolDispatcher>(&mut arg0.registry, 0x1::string::utf8(b"pool_dispatcher"))
    }

    public fun set_address_pool(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: 0x1::string::String, arg3: address) {
        assert!(arg1.version == 2, 2);
        let v0 = pool_dispatcher(arg1);
        assert!(0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::contains(v0, arg2), 3);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::set_address_pool(v0, arg2, arg3);
    }

    entry fun claim(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = depository(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x2::object_table::contains<address, 0x2::coin::Coin<TESTCOIN>>(v0, v1)) {
            let v3 = 0x2::object_table::borrow_mut<address, 0x2::coin::Coin<TESTCOIN>>(v0, v1);
            0x2::coin::split<TESTCOIN>(v3, 0x1::u64::min(arg1, 0x2::coin::value<TESTCOIN>(v3)), arg2)
        } else {
            0x2::coin::zero<TESTCOIN>(arg2)
        };
        let v4 = v2;
        let v5 = arg1 - 0x2::coin::value<TESTCOIN>(&v4);
        if (v5 > 0) {
            let v6 = treasury(arg0);
            let v7 = 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::current_epoch<TESTCOIN>(v6);
            let v8 = vesting_ledger(arg0);
            let (v9, v10) = 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::claim<TESTCOIN>(v8, v1, v5, v7, arg2);
            0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::transfer<TESTCOIN>(pool_dispatcher(arg0), 0x1::string::utf8(b"lockup"), v10);
            0x2::coin::join<TESTCOIN>(&mut v4, v9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(v4, v1);
    }

    public fun deposit_batch(arg0: &mut Vault, arg1: vector<0x2::coin::Coin<TESTCOIN>>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTCOIN>>(&mut arg1);
        0x2::pay::join_vec<TESTCOIN>(&mut v0, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::coin::split<TESTCOIN>(&mut v0, 0x1::vector::pop_back<u64>(&mut arg3), arg4);
            let v3 = depository(arg0);
            if (!0x2::object_table::contains<address, 0x2::coin::Coin<TESTCOIN>>(v3, v1)) {
                0x2::object_table::add<address, 0x2::coin::Coin<TESTCOIN>>(v3, v1, v2);
                continue
            };
            0x2::coin::join<TESTCOIN>(0x2::object_table::borrow_mut<address, 0x2::coin::Coin<TESTCOIN>>(v3, v1), v2);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun depository(arg0: &mut Vault) : &mut 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<TESTCOIN>> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<TESTCOIN>>>(&mut arg0.registry, 0x1::string::utf8(b"depository"))
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 10, b"TCON", b"Testcoin", b"TESTCOIN token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/tcoin/tcoin.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        let v2 = Vault{
            id       : 0x2::object::new(arg1),
            registry : 0x2::object_bag::new(arg1),
            version  : 2,
        };
        0x2::object_bag::add<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::PoolDispatcher>(&mut v2.registry, 0x1::string::utf8(b"pool_dispatcher"), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::default(arg1));
        0x2::object_bag::add<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::Treasury<TESTCOIN>>(&mut v2.registry, 0x1::string::utf8(b"treasury"), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::create<TESTCOIN>(v0, 3000000000000000000, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::schedule::default<TESTCOIN>(), arg1));
        0x2::object_bag::add<0x1::string::String, 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<TESTCOIN>>>(&mut v2.registry, 0x1::string::utf8(b"depository"), 0x2::object_table::new<address, 0x2::coin::Coin<TESTCOIN>>(arg1));
        0x2::object_bag::add<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::VestingLedger<TESTCOIN>>(&mut v2.registry, 0x1::string::utf8(b"vesting_ledger"), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::create<TESTCOIN>(45, 6000000000, arg1));
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
            assert!(0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::insert_entry<TESTCOIN>(treasury(arg1), arg2, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::create_entry<TESTCOIN>(arg3, arg4, arg5, arg6, arg7));
    }

    public fun lock_batch(arg0: &mut Vault, arg1: vector<0x2::coin::Coin<TESTCOIN>>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = treasury(arg0);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<TESTCOIN>>(&mut arg1);
        0x2::pay::join_vec<TESTCOIN>(&mut v1, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::lock<TESTCOIN>(vesting_ledger(arg0), 0x1::vector::pop_back<address>(&mut arg2), 0x2::coin::split<TESTCOIN>(&mut v1, 0x1::vector::pop_back<u64>(&mut arg3), arg4), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::current_epoch<TESTCOIN>(v0), arg4);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(v1, 0x2::tx_context::sender(arg4));
    }

    entry fun migrate(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 2, 1);
        if (arg1.version == 1) {
            0x2::object_bag::add<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::VestingLedger<TESTCOIN>>(&mut arg1.registry, 0x1::string::utf8(b"vesting_ledger"), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::create<TESTCOIN>(45, 6000000000, arg2));
            let v0 = pool_dispatcher(arg1);
            0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::add_address_pool(v0, 0x1::string::utf8(b"lockup"), @0xefaaecff5491118ffca9090afa473c53b937a5d2beb5b566c347bd386e5a656f);
            let v1 = VestingAdminCap{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<VestingAdminCap>(v1, 0x2::tx_context::sender(arg2));
            arg1.version = arg1.version + 1;
        };
        arg1.version = 2;
    }

    public fun mint(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        let v0 = treasury(arg0);
        let (v1, v2) = 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::mint<TESTCOIN>(v0, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = pool_dispatcher(arg0);
        while (!0x1::vector::is_empty<0x1::string::String>(&v4)) {
            0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::transfer<TESTCOIN>(v5, 0x1::vector::pop_back<0x1::string::String>(&mut v4), 0x1::vector::pop_back<0x2::coin::Coin<TESTCOIN>>(&mut v3));
        };
        0x1::vector::destroy_empty<0x1::string::String>(v4);
        0x1::vector::destroy_empty<0x2::coin::Coin<TESTCOIN>>(v3);
    }

    fun premint(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = treasury(arg0);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::transfer<TESTCOIN>(pool_dispatcher(arg0), 0x1::string::utf8(b"liquidity"), 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::premint<TESTCOIN>(v0, 150000000000000000, arg1));
    }

    public fun remove_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg1.version == 2, 2);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::remove_entry<TESTCOIN>(treasury(arg1), arg2);
    }

    public fun set_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.version == 2, 2);
        let v0 = pool_dispatcher(arg1);
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::set_entry<TESTCOIN>(treasury(arg1), arg2, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::create_entry<TESTCOIN>(arg3, arg4, arg5, arg6, arg7));
    }

    public fun set_vesting_penalty(arg0: &VestingAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg2 <= 10000000000, 4);
        assert!(arg1.version == 2, 2);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::set_initial_penalty<TESTCOIN>(vesting_ledger(arg1), arg2);
    }

    public fun set_vesting_period(arg0: &VestingAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg2 <= 1800, 4);
        assert!(arg1.version == 2, 2);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::set_vesting_period<TESTCOIN>(vesting_ledger(arg1), arg2);
    }

    fun treasury(arg0: &mut Vault) : &mut 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::Treasury<TESTCOIN> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::Treasury<TESTCOIN>>(&mut arg0.registry, 0x1::string::utf8(b"treasury"))
    }

    entry fun unblock_minting(arg0: &ScheduleAdminCap, arg1: &mut Vault) {
        assert!(arg1.version == 2, 2);
        0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::treasury::unblock_minting<TESTCOIN>(treasury(arg1));
    }

    fun vesting_ledger(arg0: &mut Vault) : &mut 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::VestingLedger<TESTCOIN> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::vesting_ledger::VestingLedger<TESTCOIN>>(&mut arg0.registry, 0x1::string::utf8(b"vesting_ledger"))
    }

    // decompiled from Move bytecode v6
}

