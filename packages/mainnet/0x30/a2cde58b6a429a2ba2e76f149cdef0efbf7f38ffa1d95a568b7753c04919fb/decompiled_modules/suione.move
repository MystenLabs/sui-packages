module 0x30a2cde58b6a429a2ba2e76f149cdef0efbf7f38ffa1d95a568b7753c04919fb::suione {
    struct SUIONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONE>(arg0, 6, b"SUIONE", b"Sui One Piece", b"The Future Pirate King of Memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabgkys6jm6ym3z2774nj36cyezuxwxz7fukkjnx47akslul23p6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIONE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

