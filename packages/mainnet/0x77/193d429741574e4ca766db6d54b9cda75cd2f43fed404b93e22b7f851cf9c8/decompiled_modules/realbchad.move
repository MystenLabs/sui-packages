module 0x77193d429741574e4ca766db6d54b9cda75cd2f43fed404b93e22b7f851cf9c8::realbchad {
    struct REALBCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALBCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALBCHAD>(arg0, 6, b"RealBchad", b"The Real Baby Chad", b"The real Baby Chad has come into the world of Chads. From his bloodline of being the greatest to ape. He pursue to be like his father - A CHAD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig4cucdgj6gqkgvvarv2jzl2axanubeq5tad6cu5s4wugwheugkoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALBCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REALBCHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

