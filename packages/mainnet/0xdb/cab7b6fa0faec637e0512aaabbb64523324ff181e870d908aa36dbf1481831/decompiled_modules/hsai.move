module 0xdbcab7b6fa0faec637e0512aaabbb64523324ff181e870d908aa36dbf1481831::hsai {
    struct HSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HSAI>(arg0, 6, b"HSAI", b"Hoshimi AI by SuiAI", b"The Hoshimi AI bot is a cutting-edge, AI-driven virtual assistant designed to enhance user interactions through intelligent conversation and task automation. It can assist with a wide range of activities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/exrgxlmm_Qg_k_A25_Dns5kb_Q_bb57b8984a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

