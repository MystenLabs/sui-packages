module 0x4d72f679f4940a48b067f68dc79df465c0be381e9ef9d60e11047ad1769941af::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 6, b"PSD", b"Professor Suggon Deeznutz", x"4920636865636b656420776974682072656e6f776e656420776f726c6420617574686f726974792c2050726f666573736f7220537567676f6e204465657a6e75747a2c20616e642068652073616964207061726f6479206973206c6567616c20696e20416d657269636120220a0a546861747320686f772050534420546f6b656e2077617320626f726e202074686520756c74696d617465206d656d65636f696e207468617473206865726520746f206d616b6520686973746f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_06_43_51_84568ab4e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

