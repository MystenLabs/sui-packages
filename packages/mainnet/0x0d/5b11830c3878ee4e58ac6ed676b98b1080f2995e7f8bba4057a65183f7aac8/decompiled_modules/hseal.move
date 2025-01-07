module 0xd5b11830c3878ee4e58ac6ed676b98b1080f2995e7f8bba4057a65183f7aac8::hseal {
    struct HSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSEAL>(arg0, 6, b"HSEAl", b"Handsome seal", b"Handsome seal surfing on the world wide web", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seal_25507d0a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

