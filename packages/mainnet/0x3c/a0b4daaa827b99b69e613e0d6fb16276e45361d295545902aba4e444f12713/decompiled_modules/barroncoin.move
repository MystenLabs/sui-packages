module 0x3ca0b4daaa827b99b69e613e0d6fb16276e45361d295545902aba4e444f12713::barroncoin {
    struct BARRONCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRONCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRONCOIN>(arg0, 6, b"BARRONCOIN", b"BARRON COIN", b"Dripping in generational wealth, only on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_01_09_22_40_A_realistic_bold_logo_for_a_meme_coin_called_Barron_Coin_The_design_features_a_tall_iconic_figure_in_a_suit_with_a_gold_crown_evoking_a_ruler_o_3b7c980f8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRONCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRONCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

