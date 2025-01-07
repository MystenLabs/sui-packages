module 0x33dc5981f148e7934bf10fefd131648cfc2035c4a3fe9a40bfc4074a1f6e934f::kekiusditto {
    struct KEKIUSDITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUSDITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUSDITTO>(arg0, 6, b"KekiusDitto", b"Kekius Dittomann", x"2841647269616e20446974746d616e6e202f20456c6f6e204d75736b29202b204b656b697573204d6178696d7573203d204b656b69757320446974746f6d616e6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_31_13_57_21_A_Roman_gladiator_styled_Pepe_the_Frog_with_glowing_veins_and_constellations_on_his_body_wearing_detailed_golden_Roman_armor_The_character_is_standi_a46f548e0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUSDITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKIUSDITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

