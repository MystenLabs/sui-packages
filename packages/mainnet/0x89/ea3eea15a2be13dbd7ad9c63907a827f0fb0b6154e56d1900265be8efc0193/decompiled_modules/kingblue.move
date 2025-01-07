module 0x89ea3eea15a2be13dbd7ad9c63907a827f0fb0b6154e56d1900265be8efc0193::kingblue {
    struct KINGBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGBLUE>(arg0, 6, b"KINGBLUE", b"BLUE THE KING", x"546865207265766f6c7574696f6e617279206d656d65636f696e206372656174656420666f7220616e20656e7468757369617374696320636f6d6d756e69747920726561647920746f206578706c6f7265206e6577206f70706f7274756e697469657320696e207468652063727970746f2073706163652e0a0a68747470733a2f2f737569626c75652e746f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3905_08aae5381b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

