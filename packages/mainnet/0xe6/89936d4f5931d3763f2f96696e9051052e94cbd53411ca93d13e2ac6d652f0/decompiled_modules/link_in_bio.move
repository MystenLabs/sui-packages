module 0xe689936d4f5931d3763f2f96696e9051052e94cbd53411ca93d13e2ac6d652f0::link_in_bio {
    struct LINK_IN_BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINK_IN_BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINK_IN_BIO>(arg0, 6, b"Link in Bio", b"Fucked Live", b"https://twitchs.cam/OiledUp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihubi6rh3a7ye7rso2vzqvn5z5v6pymuovs3wb5hu3dzme7zqzixy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK_IN_BIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LINK_IN_BIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

