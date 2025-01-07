module 0xa30c51cec9f05fec5f4d897dcf96a037f3e72af7f862f96fb1084d9c03b8bce8::iwndb {
    struct IWNDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWNDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWNDB>(arg0, 9, b"IWNDB", b"jsjd", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e5826ab-10ad-4bca-b6d1-f9e5eb26b493.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWNDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWNDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

