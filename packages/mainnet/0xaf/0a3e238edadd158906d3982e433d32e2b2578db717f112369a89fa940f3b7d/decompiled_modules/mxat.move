module 0xaf0a3e238edadd158906d3982e433d32e2b2578db717f112369a89fa940f3b7d::mxat {
    struct MXAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXAT>(arg0, 9, b"MXAT", b"Meme", b"Usuahsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76114a5a-b9ec-4b87-8075-c0698c838d62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

