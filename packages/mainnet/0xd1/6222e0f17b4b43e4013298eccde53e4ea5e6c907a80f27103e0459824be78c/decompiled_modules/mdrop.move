module 0xd16222e0f17b4b43e4013298eccde53e4ea5e6c907a80f27103e0459824be78c::mdrop {
    struct MDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDROP>(arg0, 6, b"MDROP", b"Ika Chan", x"4675636b2069742e2049206c61756e636865642069742e20244d44524f500a0a5447202b205369746520494e20524f5554452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifbo36yxcx3vr4yv2glxj5ppc7nx3ut666yxnnnd37lgh73dd7uoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MDROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

