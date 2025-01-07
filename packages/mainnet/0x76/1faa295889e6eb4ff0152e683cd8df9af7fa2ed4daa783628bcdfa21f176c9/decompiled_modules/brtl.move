module 0x761faa295889e6eb4ff0152e683cd8df9af7fa2ed4daa783628bcdfa21f176c9::brtl {
    struct BRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRTL>(arg0, 6, b"BRTL", b"BRISK TURTLE", b"Slow and steady? Not this time. Brisk Turtle is sprinting to meme glory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_045821091_8729432792.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

