module 0xdbfa0b8b635751df2be49a89376a0870ea12cdafe0818f1e90fa006c56b8bd05::suiiii {
    struct SUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIII>(arg0, 6, b"Suiiii", b"Sui", b"SuiiiiSuiiiiSuiiiiSuiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidi4vj2i33xkgjl6fxprf2cniavtukcok7cgpfq7n5qdb7rhpp4tm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIIII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

