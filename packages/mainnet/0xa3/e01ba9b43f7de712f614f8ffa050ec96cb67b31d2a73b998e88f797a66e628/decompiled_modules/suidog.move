module 0xa3e01ba9b43f7de712f614f8ffa050ec96cb67b31d2a73b998e88f797a66e628::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUIDOG MEME COIN", b"As a kind of meme coin, SUIDOG is designed with the image of a dog full of the ocean as its core, integrating classic ocean and dog elements, implying the beautiful expectation of \"rushing to the bottom of the sea\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240912223943_78d490499a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

