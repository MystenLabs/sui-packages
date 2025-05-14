module 0x49301f7421906e65bd8baacb3590b3475541d13988024df4f34e69f3f94384f4::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 6, b"EEVEE", b"Eeveelution", x"4d656d65732065766f6c76652e20536f20646f2077652c207468652045766f6c7574696f6e20426567696e73210a0a437574652e20437572696f75732e2043617061626c65206f66206265636f6d696e6720616e797468696e672e200a0a45657665652069736e2774206a75737420616e6f74686572206d656d652c20697427732061206d6f76656d656e742120496e73706972656420627920746865206d6f737420616461707461626c6520637265617475726520696e2074686520506f6b656d6f6e20756e6976657273652c2045455645452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj2h7jttfigj7srdip6qrrulq5hn5qmwstebnzqhyehjrilgjgp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

