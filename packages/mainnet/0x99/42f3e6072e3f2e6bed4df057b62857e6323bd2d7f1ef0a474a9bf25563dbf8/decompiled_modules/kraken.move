module 0x9942f3e6072e3f2e6bed4df057b62857e6323bd2d7f1ef0a474a9bf25563dbf8::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"SuiKraken", b"A legendary sea monster awakened from the depths of Suipulling in liquidity and drowning FUD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_02_11_14_54_25_A_massive_neon_blue_Kraken_rising_from_the_ocean_with_glowing_Sui_coins_for_eyes_The_Kraken_s_tentacles_are_pulling_paper_hands_into_the_deep_water_614d1bee04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

