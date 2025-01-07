module 0xe5c17d57513d3e2488895854993cdb911a6145fc7f93457bf2fb482e39d89d8d::poordog {
    struct POORDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POORDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORDOG>(arg0, 6, b"Poordog", b"POOR DOG", b"\"Poor Dog: The underdog meme that's all bark, no bucks until now!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_48ca9dae_5a58_4dee_8e71_23a01c2fbe34_f5add333f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POORDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

