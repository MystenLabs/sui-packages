module 0x82f96e4a75a7b79d3e91b0d81f57281a0c43c8ca8c2cbc2d4693fae93d0a64f4::dongoverth {
    struct DONGOVERTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONGOVERTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONGOVERTH>(arg0, 9, b"DONGOVERTH", b"Dongover", b"Hahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc830e4b-2d74-41f0-a2c0-4535849ca07d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONGOVERTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONGOVERTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

