module 0x1715fb177cce24b71304bdef55e25634b748320fab730979e941158becbc14b6::sfeg {
    struct SFEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFEG>(arg0, 6, b"SFEG", b"SUIFEG", b"SuiFeg is a community-based memecoin built on the Sui Blockchain, with a mission to bring internet culture into the web3 world in a fun and inclusive way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5ycpd4tf65xwhaihepkw3f5datayfc3inmq7bckf2zilvk3vlgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

