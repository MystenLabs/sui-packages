module 0xb33c2779affc10b5c13f25fc45f4778e2f665072ccce8a54ae993d2bf65b42a9::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"MOON JIGGLY", x"54686520756e6f6666696369616c20506f6bc3a96d6f6e206f66206d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeido3ty4r2vawaizeec2dp2kd36nqx3amokmbjvacogaqudjg7p4di")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

