module 0xccf257c2d41e1c0ba733dcc9e5da0319e7a8f8823ad1eabf440c631e6a7958fe::suishe {
    struct SUISHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHE>(arg0, 6, b"SuiShe", b"sui-she", b"don't buy, buy rugs on plsc.market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_19_37_41_Create_a_humorous_meme_style_image_featuring_a_sushi_roll_with_a_feminine_appearance_like_a_small_pink_bow_and_eyelashes_floating_on_water_The_only_dc9c349550.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

