module 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::test_sui {
    struct TEST_SUI has drop {
        dummy_field: bool,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct TreasuryCapWrapper has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TEST_SUI>,
    }

    struct TSUIMinted has copy, drop {
        amount: u256,
        recipient: address,
    }

    public entry fun mint(arg0: &mut TreasuryCapWrapper, arg1: u64, arg2: address, arg3: &MinterCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg3.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_SUI>>(0x2::coin::mint<TEST_SUI>(&mut arg0.cap, arg1, arg4), arg2);
        let v0 = TSUIMinted{
            amount    : (arg1 as u256),
            recipient : arg2,
        };
        0x2::event::emit<TSUIMinted>(v0);
    }

    public fun get_metadata_info(arg0: &0x2::coin::CoinMetadata<TEST_SUI>) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8) {
        (0x2::coin::get_name<TEST_SUI>(arg0), 0x1::string::utf8(0x1::ascii::into_bytes(0x2::coin::get_symbol<TEST_SUI>(arg0))), 0x2::coin::get_description<TEST_SUI>(arg0), 0x2::coin::get_decimals<TEST_SUI>(arg0))
    }

    fun init(arg0: TEST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST_SUI>(arg0, 9, b"TSUI", b"Test SUI", b"Test version of SUI for testing on testnets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/sui-sui-logo.png?v=040")), arg1);
        let v3 = TreasuryCapWrapper{
            id  : 0x2::object::new(arg1),
            cap : v1,
        };
        0x2::transfer::share_object<TreasuryCapWrapper>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_SUI>>(v2);
        let v4 = MinterCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<MinterCap>(v4, v0);
    }

    // decompiled from Move bytecode v6
}

