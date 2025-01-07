module 0xd4de35181f244293938b10206ced9fd47b3f4ada818921e8eedf45d93fe2c7b2::spem {
    struct SPEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEM>(arg0, 6, b"SPEM", b"SUISUSHI PEPEMOTO", b"I hold ONLY 1 SUI of $SPEM! You can see it! BUY IT, I CAN'T RUG! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_21_58_57_A_blueish_frog_character_inspired_by_the_style_of_Pepe_the_Frog_fused_with_a_nigiri_sushi_in_a_cartoon_style_The_frog_character_has_a_cute_exagger_06139af6b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

