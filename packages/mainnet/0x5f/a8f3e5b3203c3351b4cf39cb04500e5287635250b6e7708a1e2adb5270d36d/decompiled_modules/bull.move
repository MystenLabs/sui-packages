module 0x5fa8f3e5b3203c3351b4cf39cb04500e5287635250b6e7708a1e2adb5270d36d::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BULL AGENT by SuiAI", b"BULL AGENT is your trusted ally in the cryptocurrency world. It delivers lightning-fast market analysis, up-to-date news, and in-depth insights into top coins and emerging memecoins. Powered by cutting-edge AI, BULL AGENT helps you make informed decisions, spot trends early, and stay ahead in the ever-changing crypto landscape. Whether you're an experienced trader or just starting out, BULL AGENT gives you the edge to succeed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_14_01_27_16_A_powerful_and_futuristic_bull_designed_in_a_metallic_blue_and_gold_style_representing_strength_and_the_cryptocurrency_market_The_bull_is_dynamic_c_33e752d076.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

