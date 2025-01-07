module 0x7c5f904895fd24df4f32babc6571e326308dbfc22c858cc6b6e6f3c5ca5c9e03::heck123 {
    struct HECK123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HECK123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HECK123>(arg0, 9, b"HECK123", b"Heckar lo", b"Hecker looooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c994ccb0-9a90-439e-860b-8e023aded7e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HECK123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HECK123>>(v1);
    }

    // decompiled from Move bytecode v6
}

