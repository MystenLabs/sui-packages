module 0x89d90fb11ee56b2648782f01e5060c130409dacce66f2c09df3a5431620ae5f9::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAX", b"maxud78", b"MAX - will change the world)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdf81043-b711-4b43-9821-75fd942816f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

