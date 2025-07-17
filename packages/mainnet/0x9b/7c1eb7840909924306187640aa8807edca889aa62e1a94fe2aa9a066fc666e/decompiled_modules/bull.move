module 0x9b7c1eb7840909924306187640aa8807edca889aa62e1a94fe2aa9a066fc666e::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BULL", b"@suilaunchcoin $BULL + BULL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

