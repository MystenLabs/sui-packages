module 0xae54759b36ff9af0ca4c3952badb29747b15373c94465971ef55209956b52022::dsy {
    struct DSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSY>(arg0, 6, b"DSY", b"Daisy Coin", b"Daisy Coin is designed to revolutionise accounting automation and streamline transactions within the ecosystem. Built on SUI for fast, low-cost, and secure operations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_16_16_05_15_A_professional_and_minimalist_token_logo_featuring_a_daisy_flower_in_a_modern_flat_design_The_daisy_has_clean_white_petals_and_a_golden_yellow_centre_d10efbb2d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

