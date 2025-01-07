module 0x2de0daf722da0a8927c3cc288cac51580003b6e659b978b55c3ab141b078da41::sdrip {
    struct SDRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRIP>(arg0, 6, b"SDRIP", b"SuiDrip", b"SuiDrip Coin is a community-driven, meme-powered cryptocurrency built on the Sui blockchain. Combining the fun and viral energy of meme culture with the robust technology of the Sui Network, SuiDrip aims to bring an exciting and engaging experience to the crypto world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_21_00_34_A_character_design_for_Sui_Drip_featuring_a_water_themed_figure_The_character_is_made_of_liquid_water_with_a_sleek_futuristic_appearance_flowing_a_24f8772477.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

