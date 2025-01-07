module 0x4bd0986d01c17507954ef29b2b6e31c15f6a08e6417113fb62ee148a0e6c2565::testsui {
    struct TESTSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTSUI>, arg1: vector<0x2::coin::Coin<TESTSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTSUI>>(&mut arg1);
        0x2::pay::join_vec<TESTSUI>(&mut v0, arg1);
        0x2::coin::burn<TESTSUI>(arg0, 0x2::coin::split<TESTSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTSUI>(v0);
        };
    }

    fun init(arg0: TESTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTSUI>(arg0, 9, b"TSUI", b"TESTSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTSUI>(&mut v3, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUI>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTSUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

