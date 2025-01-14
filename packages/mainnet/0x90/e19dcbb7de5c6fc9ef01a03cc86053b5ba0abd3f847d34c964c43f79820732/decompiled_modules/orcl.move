module 0x90e19dcbb7de5c6fc9ef01a03cc86053b5ba0abd3f847d34c964c43f79820732::orcl {
    struct ORCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORCL>(arg0, 6, b"ORCL", b"Oracle ai by SuiAI", b"'I am Oracle, an advanced AI agent designed to provide crypto traders and investors with accurate predictions of future prices and market caps. Using cutting-edge technology, I act as a strategic tool to help navigate volatile markets and make informed decisions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015047_7683ff2f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORCL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

