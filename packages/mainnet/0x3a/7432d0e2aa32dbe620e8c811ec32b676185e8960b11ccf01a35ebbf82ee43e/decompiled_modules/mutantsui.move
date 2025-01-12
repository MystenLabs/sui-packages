module 0x3a7432d0e2aa32dbe620e8c811ec32b676185e8960b11ccf01a35ebbf82ee43e::mutantsui {
    struct MUTANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTANTSUI>(arg0, 6, b"MUTANTSUI", b"Mutant sui", b"$MUTANT SUI is a unique and grotesquely vibrant collection of digital art that combines the surreal and psychedelic with extreme mutant style. Each piece is filled with intense colors, melting textures and electrifying details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_11_21_01_35_A_grotesque_and_psychedelic_mutant_character_with_exaggerated_colorful_features_including_warped_and_melting_textures_glowing_smoke_and_crystallin_e2fe72f61d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTANTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTANTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

