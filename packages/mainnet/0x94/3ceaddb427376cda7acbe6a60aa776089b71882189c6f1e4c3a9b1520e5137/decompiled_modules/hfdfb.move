module 0x943ceaddb427376cda7acbe6a60aa776089b71882189c6f1e4c3a9b1520e5137::hfdfb {
    struct HFDFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFDFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFDFB>(arg0, 9, b"HFDFB", x"d0a0d0b2d0b0d0bc", b"Bdsfc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f999dcc0-a79c-47f2-a259-a26fff814597.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFDFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFDFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

