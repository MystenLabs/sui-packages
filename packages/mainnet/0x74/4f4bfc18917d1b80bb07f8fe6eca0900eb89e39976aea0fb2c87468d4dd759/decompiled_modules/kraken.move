module 0x744f4bfc18917d1b80bb07f8fe6eca0900eb89e39976aea0fb2c87468d4dd759::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"SuiKraken", b" A legendary sea monster awakened from the depths of Suipulling in liquidity and drowning FUD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_02_11_14_54_25_A_massive_neon_blue_Kraken_rising_from_the_ocean_with_glowing_Sui_coins_for_eyes_The_Kraken_s_tentacles_are_pulling_paper_hands_into_the_deep_water_0ce8ab3b39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

