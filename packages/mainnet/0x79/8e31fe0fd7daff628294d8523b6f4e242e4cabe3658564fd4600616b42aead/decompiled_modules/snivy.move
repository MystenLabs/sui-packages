module 0x798e31fe0fd7daff628294d8523b6f4e242e4cabe3658564fd4600616b42aead::snivy {
    struct SNIVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIVY>(arg0, 6, b"SNIVY", b"Suinivy", x"536e69767920697320612047726173732d7479706520506f6bc3a96d6f6e20696e20506f6bc3a96d6f6e20474f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihw3cxclwmvkqhd7knrj4x6yfuvc5lpl3olqdrsahmjspk6qtfccm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIVY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

