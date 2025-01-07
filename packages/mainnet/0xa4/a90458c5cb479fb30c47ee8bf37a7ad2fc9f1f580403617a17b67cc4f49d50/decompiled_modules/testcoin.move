module 0xa4a90458c5cb479fb30c47ee8bf37a7ad2fc9f1f580403617a17b67cc4f49d50::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: vector<0x2::coin::Coin<TESTCOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTCOIN>>(&mut arg1);
        0x2::pay::join_vec<TESTCOIN>(&mut v0, arg1);
        0x2::coin::burn<TESTCOIN>(arg0, 0x2::coin::split<TESTCOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTCOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTCOIN>(v0);
        };
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTCOIN>(arg0, 7, b"TC", b"TESTCOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTCOIN>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCOIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

