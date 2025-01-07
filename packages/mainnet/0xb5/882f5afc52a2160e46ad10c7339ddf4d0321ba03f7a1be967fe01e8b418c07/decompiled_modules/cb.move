module 0xb5882f5afc52a2160e46ad10c7339ddf4d0321ba03f7a1be967fe01e8b418c07::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CB>(arg0, 6, b"CB", b"CryptoBot by SuiAI", b"CryptoBot is an intelligent assistant that helps users stay informed about cryptocurrency trends, prices, and market risks. It provides real-time data and actionable insights to guide crypto traders and investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_18_52_54_A_minimalistic_logo_for_a_cryptocurrency_assistant_bot_featuring_a_simple_sleek_coin_design_with_a_stylized_graph_or_upward_arrow_incorporated_into_d54dabdf4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

