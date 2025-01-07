module 0xfd7fffd5613ec8474b1f1eba46595388a743ab657b6ee2bfb630e9b8e7a03d4a::rezo {
    struct REZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REZO>(arg0, 9, b"REZO", b"Rzrll", b"First token on ghg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9044e90c-6cf4-4117-ab14-15e0bcc4eefa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

