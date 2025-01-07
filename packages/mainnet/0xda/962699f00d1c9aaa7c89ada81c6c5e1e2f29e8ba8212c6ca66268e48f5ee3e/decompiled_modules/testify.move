module 0xda962699f00d1c9aaa7c89ada81c6c5e1e2f29e8ba8212c6ca66268e48f5ee3e::testify {
    struct TESTIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTIFY>(arg0, 6, b"Testify", b"LOL TESTING HERE", b"SDSDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/canvas_export_15_bfb03409d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

