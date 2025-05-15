module 0x825fbcfd75bd56ef5c61e332eb28feb69e3fd166e20e7839d479571aedbbdd5f::snivy {
    struct SNIVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIVY>(arg0, 6, b"SNIVY", b"Suinivy", x"536e69767920697320612047726173732d7479706520506f6bc3a96d6f6e20696e20506f6bc3a96d6f6e20474f2e20417320612047726173732d7479706520506f6bc3a96d6f6e2e20536e6976792773206d6178696d756d20436f6d62617420506f7765722073746174206973203936302043502c20616e6420697473206265737420506f6bc3a96d6f6e20474f206d6f766573206172652056696e65205768697020616e64205365656420426f6d622e20536e69767920656e636f756e746572732061726520626f6f7374656420647572696e672053756e6e792077656174686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihw3cxclwmvkqhd7knrj4x6yfuvc5lpl3olqdrsahmjspk6qtfccm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIVY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

