module 0x398ed0ff316fc204f91e775ce11714bb9c9de7d67a8bc8ed564c68cfb5ae5c6b::testcnthree {
    struct TESTCNTHREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCNTHREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCNTHREE>(arg0, 9, b"TESTCNTHREE", b"Test Coin Three", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TESTCNTHREE>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCNTHREE>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCNTHREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

