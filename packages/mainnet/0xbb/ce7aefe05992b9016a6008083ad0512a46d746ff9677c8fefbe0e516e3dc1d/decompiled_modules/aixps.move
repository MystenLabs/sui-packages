module 0xbbce7aefe05992b9016a6008083ad0512a46d746ff9677c8fefbe0e516e3dc1d::aixps {
    struct AIXPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXPS>(arg0, 6, b"AIXPS", b"aixps by SuiAI", b"It's a cutting-edge AI-powered crypto agent designed to empower traders, investors, and enthusiasts in the blockchain ecosystem. With the knowledge of a market analyst and the confidence of a GIGA CHAD, AIXPS blends sharp technical insights, witty engagement, and bold decision-making guidance to help you conquer the ever-evolving crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_06_13_33_33_A_sleek_futuristic_logo_for_AIXPS_an_AI_agent_in_the_crypto_and_blockchain_space_The_design_features_bold_yellow_fonts_for_the_letters_AIXPS_wit_62f517fcc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

