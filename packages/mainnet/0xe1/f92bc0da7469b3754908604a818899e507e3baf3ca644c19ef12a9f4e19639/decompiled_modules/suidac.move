module 0xe1f92bc0da7469b3754908604a818899e507e3baf3ca644c19ef12a9f4e19639::suidac {
    struct SUIDAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAC>(arg0, 6, b"SUIDAC", b"Suiderace Pokemon Battle", b"SUIDAC MAKE POKEMON BATTLE GAME ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3vduh2wfm42vl7rmitru2srth4ycbelpsfvlbu6xjgwbl2w7oti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDAC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

