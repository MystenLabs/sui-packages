module 0xa847921b0e78dc5c5ccb950b41bc2a496fd4d0f31537e2ed92663835c5d0a596::muni {
    struct MUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNI>(arg0, 9, b"MUNI", b"Muning", x"4d756e696e6720697320612076696272616e7420636f6d6d756e69747920687562206f6e2074686520537569206e6574776f726b2c20666f73746572696e67206d65616e696e6766756c20636f6e6e656374696f6e7320616e6420636f6c6c61626f726174696f6e730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b195e66-b055-418f-af1f-b47f49ba1bb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

