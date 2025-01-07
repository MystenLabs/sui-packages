module 0x7cec6ab97cc03830d50733489b3fb0b7607864f5215c86d768ac6c58fcb9407a::stepangigo {
    struct STEPANGIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPANGIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPANGIGO>(arg0, 9, b"STEPANGIGO", b"Gigo", b"The first real CryptoStepanGigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7101c0df-dc87-4c27-975e-d8082d9f4773.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPANGIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPANGIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

