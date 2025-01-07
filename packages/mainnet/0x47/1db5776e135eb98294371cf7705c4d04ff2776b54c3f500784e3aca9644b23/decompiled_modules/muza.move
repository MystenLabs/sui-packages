module 0x471db5776e135eb98294371cf7705c4d04ff2776b54c3f500784e3aca9644b23::muza {
    struct MUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUZA>(arg0, 9, b"MUZA", b"Muzaratti", b"A unique name comes from nowhere ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/132bfe92-a909-414a-b595-0d8a09fdd749.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

