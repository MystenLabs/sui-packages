module 0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc {
    struct TESTGLDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTGLDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTGLDC>(arg0, 6, b"TestGLDC", b"TestGLDC", b"TestGLDC is a test of a 1:1 gold backed token. 1 TestGLDC represents 1/1000 of 1 troy oz of gold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNhBaQUFgPdnV9sRZmnBUERqqe88o9XbvVKRgZvAhddrg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTGLDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTGLDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

