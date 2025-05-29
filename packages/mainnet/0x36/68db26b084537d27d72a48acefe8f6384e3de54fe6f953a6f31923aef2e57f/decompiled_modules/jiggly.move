module 0x3668db26b084537d27d72a48acefe8f6384e3de54fe6f953a6f31923aef2e57f::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"Jiggly", b"Jiggly on SUI", x"54686520756e6f6666696369616c20506f6bc3a96d6f6e20666f72206d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6fdlyemtsd6som2x4hkrdfkfmcmnniulq4dxozq32kil37fkb5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

