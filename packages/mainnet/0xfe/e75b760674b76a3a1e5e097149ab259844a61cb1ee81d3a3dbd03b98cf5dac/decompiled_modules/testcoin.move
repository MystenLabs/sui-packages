module 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    struct ScheduleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object_bag::ObjectBag,
        version: u64,
    }

    fun pool_dispatcher(arg0: &mut Vault) : &mut 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::PoolDispatcher {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::PoolDispatcher>(&mut arg0.registry, 0x1::string::utf8(b"pool_dispatcher"))
    }

    public fun set_address_pool(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: 0x1::string::String, arg3: address) {
        assert!(arg1.version == 1, 2);
        let v0 = pool_dispatcher(arg1);
        assert!(0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::contains(v0, arg2), 3);
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::set_address_pool(v0, arg2, arg3);
    }

    entry fun claim(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = depository(arg0);
        if (0x2::coin::value<TESTCOIN>(0x2::object_table::borrow<address, 0x2::coin::Coin<TESTCOIN>>(v0, 0x2::tx_context::sender(arg2))) == 0) {
            0x2::coin::destroy_zero<TESTCOIN>(0x2::object_table::remove<address, 0x2::coin::Coin<TESTCOIN>>(v0, 0x2::tx_context::sender(arg2)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(0x2::coin::split<TESTCOIN>(0x2::object_table::borrow_mut<address, 0x2::coin::Coin<TESTCOIN>>(v0, 0x2::tx_context::sender(arg2)), arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun deposit_batch(arg0: &mut Vault, arg1: vector<0x2::coin::Coin<TESTCOIN>>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
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
            version  : 1,
        };
        0x2::object_bag::add<0x1::string::String, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::PoolDispatcher>(&mut v2.registry, 0x1::string::utf8(b"pool_dispatcher"), 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::default(arg1));
        0x2::object_bag::add<0x1::string::String, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::Treasury<TESTCOIN>>(&mut v2.registry, 0x1::string::utf8(b"treasury"), 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::create<TESTCOIN>(v0, 3000000000000000000, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::schedule::default<TESTCOIN>(), arg1));
        0x2::object_bag::add<0x1::string::String, 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<TESTCOIN>>>(&mut v2.registry, 0x1::string::utf8(b"depository"), 0x2::object_table::new<address, 0x2::coin::Coin<TESTCOIN>>(arg1));
        let v3 = &mut v2;
        premint(v3, arg1);
        let v4 = ScheduleAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ScheduleAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Vault>(v2);
    }

    public fun insert_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.version == 1, 2);
        let v0 = pool_dispatcher(arg1);
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::insert_entry<TESTCOIN>(treasury(arg1), arg2, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::create_entry<TESTCOIN>(arg3, arg4, arg5, arg6, arg7));
    }

    public fun mint(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = treasury(arg0);
        let (v1, v2) = 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::mint<TESTCOIN>(v0, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = pool_dispatcher(arg0);
        while (!0x1::vector::is_empty<0x1::string::String>(&v4)) {
            0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::transfer<TESTCOIN>(v5, 0x1::vector::pop_back<0x1::string::String>(&mut v4), 0x1::vector::pop_back<0x2::coin::Coin<TESTCOIN>>(&mut v3));
        };
        0x1::vector::destroy_empty<0x1::string::String>(v4);
        0x1::vector::destroy_empty<0x2::coin::Coin<TESTCOIN>>(v3);
    }

    fun premint(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = treasury(arg0);
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::transfer<TESTCOIN>(pool_dispatcher(arg0), 0x1::string::utf8(b"liquidity"), 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::premint<TESTCOIN>(v0, 150000000000000000, arg1));
    }

    public fun remove_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg1.version == 1, 2);
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::remove_entry<TESTCOIN>(treasury(arg1), arg2);
    }

    public fun set_entry(arg0: &ScheduleAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.version == 1, 2);
        let v0 = pool_dispatcher(arg1);
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::pool_dispatcher::contains(v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v2)), 3);
            v2 = v2 + 1;
        };
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::set_entry<TESTCOIN>(treasury(arg1), arg2, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::create_entry<TESTCOIN>(arg3, arg4, arg5, arg6, arg7));
    }

    fun treasury(arg0: &mut Vault) : &mut 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::Treasury<TESTCOIN> {
        0x2::object_bag::borrow_mut<0x1::string::String, 0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::Treasury<TESTCOIN>>(&mut arg0.registry, 0x1::string::utf8(b"treasury"))
    }

    entry fun unblock_minting(arg0: &ScheduleAdminCap, arg1: &mut Vault) {
        assert!(arg1.version == 1, 2);
        0xfee75b760674b76a3a1e5e097149ab259844a61cb1ee81d3a3dbd03b98cf5dac::treasury::unblock_minting<TESTCOIN>(treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

