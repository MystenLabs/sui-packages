module 0x2049c1b90ecc36ca8edab9c72a3677cd90c1a2eddfe04d3c9d3e38cbe5da4d7c::whog {
    struct WHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOG>(arg0, 6, b"WHOG", b"WartHog", x"5761727468686f6720436f696e20282457484f472920207c205468652077696c64657374206d656d6520636f696e20696e207468652063727970746f206a756e676c652e200a4275696c7420646966666572656e742c20756e73746f707061626c652c20616e64206368617267696e6720746f20746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hog_27cddc27f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

