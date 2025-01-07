module 0x1465c6ffcdab5b72f0539463869d0630dec071727e4d2bac6ef61319e7666fd4::gats {
    struct GATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATS>(arg0, 9, b"GATS", b"GOAT Lord", b"GOAsT Lord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18f4e61a-7e78-4aad-9c4a-440bc09357a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

