module 0x847d0a97b1a7a3909ff81064af29c3c0c48787bbf1d0343772d6448ebcbc9c9d::evlwlf {
    struct EVLWLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVLWLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVLWLF>(arg0, 9, b"EVLWLF", b"Evil Wolf", b"a very angry and dissatisfied wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c11d9017-3dd8-4ff8-a978-59f788a8b6e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVLWLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVLWLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

