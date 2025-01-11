module 0x61d68367a876ce34da65312c42ff7006bb0f2e1ab5d837993d108d89c259a51b::btcai {
    struct BTCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTCAI>(arg0, 6, b"BTCAI", b"Bitcoin Ai by SuiAI", b"Artificial Intelligence Cryptocurrency Named Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1736618191101_8e71cab84a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTCAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

