module 0xaf53eaf9156c26f3fc725b5fb919ec31521aeba6ba914c3716c8c6eb809432b5::teddyai {
    struct TEDDYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEDDYAI>(arg0, 6, b"TEDDYAI", b"TeddyAI by SuiAI", b"The OG $TEDDY of SUI in SUAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/11_8dfa382f80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEDDYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

