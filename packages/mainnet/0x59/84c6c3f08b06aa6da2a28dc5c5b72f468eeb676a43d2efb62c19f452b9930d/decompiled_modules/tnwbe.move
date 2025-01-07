module 0x5984c6c3f08b06aa6da2a28dc5c5b72f468eeb676a43d2efb62c19f452b9930d::tnwbe {
    struct TNWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNWBE>(arg0, 9, b"TNWBE", b"bdbd", b"bdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/865de840-2d58-4256-8cf6-98b5962b5b98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

