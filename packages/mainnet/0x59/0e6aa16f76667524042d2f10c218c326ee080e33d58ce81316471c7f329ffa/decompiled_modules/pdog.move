module 0x590e6aa16f76667524042d2f10c218c326ee080e33d58ce81316471c7f329ffa::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"Peng Dog", b"a dog looks like a penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fotor_ai_2024112214852_a879e4ca67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

