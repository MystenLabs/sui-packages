module 0x1241c04b2781ae8be7b318729d4ba76e49da92f767920dced92979e41875bf12::suihale {
    struct SUIHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHALE>(arg0, 6, b"SUIHALE", b"suihale", x"5320706c6173680a55206e6e6563636573736172790a49206e63656c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_06_16_01_04_47_A_simple_cartoon_style_whale_designed_as_a_meme_token_character_The_whale_is_plump_and_cute_with_a_minimalist_design_featuring_big_expressive_eyes_43d8f83168.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

