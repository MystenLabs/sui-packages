module 0xb66e249e7bc226a8cdf73201fd14b82ddeb9658ce0a0a768b7466d1030d7e042::odor {
    struct ODOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOR>(arg0, 6, b"ODOR", b"odor", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_QZ_7lo_X_400x400_a80c954ed9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

