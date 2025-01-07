module 0x54407f1fb9fb2c3f67365aac67853505df7ac69b6de0b84ba3c0fcfdbcef5c3c::frxnd {
    struct FRXND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRXND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRXND>(arg0, 9, b"FRXND", b"Firexend", b"F&F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f3585dd-877e-48f9-a280-e4d60c0df6a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRXND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRXND>>(v1);
    }

    // decompiled from Move bytecode v6
}

