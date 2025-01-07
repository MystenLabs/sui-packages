module 0xe5c85cbafb431a14886636e82ddcccf66ebda1fbc7fbb1433f6aeef4248b8405::testmkb {
    struct TESTMKB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTMKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTMKB>(arg0, 9, b"TESTMKB", b"testmkb", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTMKB>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTMKB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTMKB>>(v1);
    }

    // decompiled from Move bytecode v6
}

