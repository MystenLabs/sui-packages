module 0x80bb2733d1f9f447e9910fb48f867f8509cefbf43b2c70dfb018a36cc3a44d79::c {
    struct C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C>(arg0, 9, b"C", b"Ccc", x"4974e28099732061206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65be9912-18e9-4f41-8f18-3301ebe98705.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C>>(v1);
    }

    // decompiled from Move bytecode v6
}

