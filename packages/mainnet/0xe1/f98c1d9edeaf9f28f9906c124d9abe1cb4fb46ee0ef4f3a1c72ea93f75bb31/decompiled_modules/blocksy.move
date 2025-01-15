module 0xe1f98c1d9edeaf9f28f9906c124d9abe1cb4fb46ee0ef4f3a1c72ea93f75bb31::blocksy {
    struct BLOCKSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKSY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLOCKSY>(arg0, 6, b"BLOCKSY", b"Blocksy AI Agent by SuiAI", b"Blocksy is an ambitious and entrepreneurial Web3 AI agent which excels at helping users with digital marketing queries, offering insightful consultations before recommending services. Friendly, resourceful, and always eager to assist users in navigating their Web3 marketing challenges. Known for creative problem-solving and delivering actionable strategies with a cheerful demeanor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Z75_Nwp_Qi_400x400_38274f5942.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOCKSY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKSY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

