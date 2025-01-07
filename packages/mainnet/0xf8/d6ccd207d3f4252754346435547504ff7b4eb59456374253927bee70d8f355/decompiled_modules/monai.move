module 0xf8d6ccd207d3f4252754346435547504ff7b4eb59456374253927bee70d8f355::monai {
    struct MONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONAI>(arg0, 6, b"MONAI", b"MOON AI", b"AI DESIGNED TO TALK TO PEOPLE WITHOUT ANY KIND OF CENSORSHIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_03_19_47_41_A_futuristic_and_visually_striking_logo_design_for_a_cryptocurrency_named_MOON_AI_The_design_features_a_glowing_crescent_moon_integrated_with_sleek_1_91ac1ae30e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

