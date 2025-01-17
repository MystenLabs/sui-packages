module 0xfba45cdeacf3a217ad2bba172338d3fdbe66ade37c18f84484021edc05480dfa::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hoppy_sui by SuiAI", b"https://x.com/hoppy_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/m_Tpgnn_Ko_400x400_09dd5832e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOPPY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

