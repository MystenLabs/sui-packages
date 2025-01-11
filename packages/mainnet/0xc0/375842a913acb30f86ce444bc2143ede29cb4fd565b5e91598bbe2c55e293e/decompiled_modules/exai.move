module 0xc0375842a913acb30f86ce444bc2143ede29cb4fd565b5e91598bbe2c55e293e::exai {
    struct EXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EXAI>(arg0, 6, b"EXAI", b"ExpoAgentAI by SuiAI", b"Empowering individuals to thrive in the Exponential Age by combining the transformative power of AI and blockchain. The ExpoAgentAI fosters financial independence, facilitates investments in emerging technologies, and builds a community of innovators.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Expo_Agent_AI_Profile_ae910bfd1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

