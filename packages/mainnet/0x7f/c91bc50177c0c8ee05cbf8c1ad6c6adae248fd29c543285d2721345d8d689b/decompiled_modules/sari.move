module 0x7fc91bc50177c0c8ee05cbf8c1ad6c6adae248fd29c543285d2721345d8d689b::sari {
    struct SARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SARI>(arg0, 6, b"SARI", b"SARI by SuiAI", b"SARI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_d90432d402.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SARI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

