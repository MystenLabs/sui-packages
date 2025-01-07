module 0xb4be1b0ee6c7ec547ccf97474e23cf64f56a68099496076ad52307eac13c0312::asha {
    struct ASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASHA>(arg0, 6, b"ASHA", b"Agent Shark by SuiAI", b"Agent Shark, deployed on the SUI network, is looking for new projects across all blockchains, have in-depth knowledge of tokens and nascent AI agents on the SUI network, and pay close attention to a project's liquidity, the daily trading volume of each token, and the potential of each token. Additionally, it analyzes the bubble map of wallets and ensure proper distribution of supply among holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AGENT_SHARK_6992f29e05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASHA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

