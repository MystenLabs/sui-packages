module 0xc2b805e7ac2fc4efd3e743bd3c3788b5d51784631b389dbf1b56b8a2e6cf222a::BND {
    struct BND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BND>(arg0, 6, b"Bandit", b"Bnd", b"A token that is more than a memecoin, it is an invitation to hunt the bandit and get the best reward in the wild old crypto west.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreic7bveewptmw7jjkpqju2b5dbdepptmwklp4vlezjrot5bbwigopy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BND>>(v0, @0x3b351058460b711e0dcc45b7be9ab2ad303ab99cd46d8c60e4c39b20714e891);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BND>>(v1);
    }

    // decompiled from Move bytecode v6
}

