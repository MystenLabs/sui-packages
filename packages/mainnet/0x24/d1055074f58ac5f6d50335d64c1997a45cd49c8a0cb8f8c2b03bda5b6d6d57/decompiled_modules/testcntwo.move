module 0x24d1055074f58ac5f6d50335d64c1997a45cd49c8a0cb8f8c2b03bda5b6d6d57::testcntwo {
    struct TESTCNTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCNTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCNTWO>(arg0, 3, b"TESTCNTWO", b"TESTCOIN2", b"Test coin 2", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTCNTWO>(&mut v2, 20000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCNTWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCNTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

