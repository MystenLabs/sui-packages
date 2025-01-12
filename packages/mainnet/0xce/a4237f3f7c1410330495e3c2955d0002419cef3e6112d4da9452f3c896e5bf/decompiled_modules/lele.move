module 0xcea4237f3f7c1410330495e3c2955d0002419cef3e6112d4da9452f3c896e5bf::lele {
    struct LELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LELE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LELE>(arg0, 6, b"LELE", b"Ledger Lens AI by SuiAI", b"The Ledger Lens AI turns raw blockchain transaction data into readable, conversational summaries. Users can input a wallet address, contract address, or specific transaction ID, and the agent provides insights in a chat-like format.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HXZ_2_J8_APJ_8_TPXKH_6_P5_HJQ_5_GYN_0_b2bc2ec7e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LELE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LELE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

