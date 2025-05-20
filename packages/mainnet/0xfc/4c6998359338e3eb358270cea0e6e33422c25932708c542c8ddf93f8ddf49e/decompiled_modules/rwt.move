module 0xfc4c6998359338e3eb358270cea0e6e33422c25932708c542c8ddf93f8ddf49e::rwt {
    struct RWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWT>(arg0, 6, b"RWT", b"ROWLETSUI", x"526f776c65747420697320612047726173732f466c79696e672d7479706520506f6bc3a96d6f6e2c20526561647920746f20636f6e717565722074686520537569207761746572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmneuyzvnbiist65fxdytnz7rvupgdxazu3odsxsntjslovhgkk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RWT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

