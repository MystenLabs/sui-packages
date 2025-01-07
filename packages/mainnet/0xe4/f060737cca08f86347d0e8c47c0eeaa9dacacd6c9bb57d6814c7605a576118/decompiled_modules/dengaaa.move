module 0xe4f060737cca08f86347d0e8c47c0eeaa9dacacd6c9bb57d6814c7605a576118::dengaaa {
    struct DENGAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGAAA>(arg0, 6, b"DENGAAA", b"DENG AAA", b"Is it a AAAcat? Is it a MooDeng? It's both!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_02_18_02_An_8_bit_old_school_video_game_style_image_featuring_two_characters_inspired_by_AAA_Cat_and_Moo_Deng_crypto_tokens_The_AAA_Cat_character_has_feline_f_085c37e1d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

