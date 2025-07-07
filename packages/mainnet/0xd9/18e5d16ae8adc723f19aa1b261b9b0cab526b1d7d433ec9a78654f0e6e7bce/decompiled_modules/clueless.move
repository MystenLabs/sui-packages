module 0xd918e5d16ae8adc723f19aa1b261b9b0cab526b1d7d433ec9a78654f0e6e7bce::clueless {
    struct CLUELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUELESS>(arg0, 6, b"CLUELESS", b"CLUELESS COIN", b"$CLUELESS is powered by confusion, run by a community that agrees on nothing, and lives for the chaos of the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmsep3btfktmodos3ybtsrmkz435eyjsyjqwnr23gmabx5mfodtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUELESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLUELESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

