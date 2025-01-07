module 0x1fef86874a4c2e64a6015f3e7487078d1e47e95f1b939428592ea1b7f7134844::bluebtc {
    struct BLUEBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBTC>(arg0, 6, b"BLUEBTC", b"BlueBitcoin", b"Blue Coin on SUI: reinventing digital gold, but make it blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_29_12_02_29_A_minimal_and_modern_logo_for_Blue_BTC_featuring_the_iconic_Bitcoin_symbol_a_stylized_in_a_bold_blue_color_The_design_has_a_clean_circular_coin_o_1695166dd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

