module 0xfb4bc75db975ba6ef874f5af37ad22294cbb3f5b0e08b52e78d08daca5f884ad::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"Suiii", b"Sui", b"SuiToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidi4vj2i33xkgjl6fxprf2cniavtukcok7cgpfq7n5qdb7rhpp4tm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

