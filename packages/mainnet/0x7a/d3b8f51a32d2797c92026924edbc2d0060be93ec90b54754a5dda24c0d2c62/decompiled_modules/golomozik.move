module 0x7ad3b8f51a32d2797c92026924edbc2d0060be93ec90b54754a5dda24c0d2c62::golomozik {
    struct GOLOMOZIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLOMOZIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLOMOZIK>(arg0, 9, b"GOLOMOZIK", b"Roxx", b"Rusik Dexter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6372c22d-b9b2-4331-9868-ac3f66d37b70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLOMOZIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLOMOZIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

