module 0x5960b1ccc59554482909cbbd3d756994ca63c2a5535adbbb772414321a5a7220::dmoon {
    struct DMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOON>(arg0, 6, b"DMOON", b"Dapp Moons", b"Discover the future of decentralized finance with Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifx2j6clkhk7fjitldnyyyqirtn3sxq5brqp6owfvk2yq22475zxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

