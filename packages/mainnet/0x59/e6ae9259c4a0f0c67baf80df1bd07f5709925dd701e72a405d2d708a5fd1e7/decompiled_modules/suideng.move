module 0x59e6ae9259c4a0f0c67baf80df1bd07f5709925dd701e72a405d2d708a5fd1e7::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"SUIDENG", b"SuiDeng", x"0a546865206865726f20486970706f2066726f6d205355492077616e747320746f20736176652074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_01_19_38_20_A_heroic_pygmy_hippo_named_MOODENG_illustrated_in_American_comic_book_style_MOODENG_has_deep_grey_blue_skin_with_a_glossy_sheen_wearing_a_deep_blue_4580c9fb38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

