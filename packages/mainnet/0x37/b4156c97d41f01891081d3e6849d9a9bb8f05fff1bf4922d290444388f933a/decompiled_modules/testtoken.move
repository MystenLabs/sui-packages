module 0x37b4156c97d41f01891081d3e6849d9a9bb8f05fff1bf4922d290444388f933a::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: vector<0x2::coin::Coin<TESTTOKEN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTTOKEN>>(&mut arg1);
        0x2::pay::join_vec<TESTTOKEN>(&mut v0, arg1);
        0x2::coin::burn<TESTTOKEN>(arg0, 0x2::coin::split<TESTTOKEN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTTOKEN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTTOKEN>(v0);
        };
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 7, b"TT", b"TESTTOKEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTTOKEN>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

