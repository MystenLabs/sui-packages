module 0xdf0df3d60c7ea636ee8bea8ecfceef8ffbeb19bc9c2d39a144314e34c63d747e::dddeng {
    struct DDDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDENG>(arg0, 6, b"DDDeng", b"Deng Deng Deng", b"Power of 3 Deng Hippos in one. Bring it on!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_02_39_13_A_retro_8_bit_style_video_game_scene_called_Deng_Deng_Deng_featuring_three_Moo_Deng_characters_that_resemble_pixelated_hippo_like_creatures_Each_c_134e1c7861.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

