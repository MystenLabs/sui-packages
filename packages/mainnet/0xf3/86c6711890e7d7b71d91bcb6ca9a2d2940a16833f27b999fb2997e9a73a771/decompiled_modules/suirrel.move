module 0xf386c6711890e7d7b71d91bcb6ca9a2d2940a16833f27b999fb2997e9a73a771::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"SUIRREL", b"SQUIRREL BUT SUI", b"SUIRREL is more than just a meme coin. Our mission is to create a welcoming space where everyone can contribute, collaborate, and have fun together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirrel_9a0877bcb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

