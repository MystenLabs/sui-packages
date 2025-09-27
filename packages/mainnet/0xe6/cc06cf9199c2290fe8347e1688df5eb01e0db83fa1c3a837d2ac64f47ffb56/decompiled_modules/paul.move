module 0xe6cc06cf9199c2290fe8347e1688df5eb01e0db83fa1c3a837d2ac64f47ffb56::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"PAUL", b"Paul strategy", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PAUL>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

