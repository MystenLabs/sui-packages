module 0x1e4a051a51899ee207fd52d1ef127f00ecc3f9cce0a4dfde15b1eeada34e9f3a::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 9, b"COOK", x"436f6f6b20f09f91a8e2808df09f8db3", x"466972737420636f6f6b206d656d65206f6e205375692c206a6f696e20696e206c6574277320636f6f6b21f09f91a8e2808df09f8db3f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2c3236b-b6ff-41d0-b49d-81332aad60d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

