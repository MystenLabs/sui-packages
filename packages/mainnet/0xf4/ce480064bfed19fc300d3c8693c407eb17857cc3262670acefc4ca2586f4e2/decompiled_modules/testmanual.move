module 0xf4ce480064bfed19fc300d3c8693c407eb17857cc3262670acefc4ca2586f4e2::testmanual {
    struct TESTMANUAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTMANUAL>, arg1: vector<0x2::coin::Coin<TESTMANUAL>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTMANUAL>>(&mut arg1);
        0x2::pay::join_vec<TESTMANUAL>(&mut v0, arg1);
        0x2::coin::burn<TESTMANUAL>(arg0, 0x2::coin::split<TESTMANUAL>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTMANUAL>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTMANUAL>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTMANUAL>(v0);
        };
    }

    fun init(arg0: TESTMANUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTMANUAL>(arg0, 9, b"TM", b"TESTMANUAL", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTMANUAL>(&mut v3, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTMANUAL>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTMANUAL>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTMANUAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTMANUAL>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTMANUAL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTMANUAL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

