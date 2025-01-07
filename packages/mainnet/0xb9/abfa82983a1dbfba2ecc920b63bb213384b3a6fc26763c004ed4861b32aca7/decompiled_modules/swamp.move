module 0xb9abfa82983a1dbfba2ecc920b63bb213384b3a6fc26763c004ed4861b32aca7::swamp {
    struct SWAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAMP>(arg0, 6, b"SWAMP", b"Drain The Swamp", b"SWAMP Token - Draining the Swamp One Step at a Time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_05_21_46_37_A_high_quality_patriotic_logo_for_the_SWAMP_token_featuring_Donald_the_bull_in_blue_The_bull_has_a_fierce_determined_expression_with_wild_orange_ha_e721843333.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

