module 0xe9deb4e7860a428b79cd108ec90010858daf9d1f31d557c51279ce060f70c683::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BluE", b"SUI BLUE", x"0a0a546865207265766f6c7574696f6e617279206d656d65636f696e206372656174656420666f7220616e20656e7468757369617374696320636f6d6d756e69747920726561647920746f206578706c6f7265206e6577206f70706f7274756e697469657320696e207468652063727970746f2073706163652e0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241018_183009_991_f77ef0d589.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

