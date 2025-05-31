module 0x127b1a50e796adf19725ec0b8b99839c01264b4fe027c23e79744ea8487db159::chloe {
    struct CHLOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLOE>(arg0, 6, b"Chloe", b"Chloe on Sui", b"SUI DALMATIAN DOG Super kind, gentle and smart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid24sdly2vrovxis5ugsmwsjpfdglv6pfikopr33hwlf54hthoney")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHLOE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

