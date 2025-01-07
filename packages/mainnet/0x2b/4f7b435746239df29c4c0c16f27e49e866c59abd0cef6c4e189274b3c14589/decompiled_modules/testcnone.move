module 0x2b4f7b435746239df29c4c0c16f27e49e866c59abd0cef6c4e189274b3c14589::testcnone {
    struct TESTCNONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCNONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCNONE>(arg0, 8, b"TESTCNONE", b"TESTCOIN1", b"Test coin 1", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTCNONE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCNONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCNONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

