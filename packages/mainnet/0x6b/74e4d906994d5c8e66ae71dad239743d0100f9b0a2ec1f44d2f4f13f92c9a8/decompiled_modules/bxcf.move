module 0x6b74e4d906994d5c8e66ae71dad239743d0100f9b0a2ec1f44d2f4f13f92c9a8::bxcf {
    struct BXCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BXCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BXCF>(arg0, 9, b"BXCF", b"EFEF", b"BXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8989e4a8-751e-4f79-8c79-1113a2c6f039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BXCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BXCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

