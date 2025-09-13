module 0x3a41cb2cbf3a12569f20ca8ae1ccfb7bc325c5d205a4364c5822596d1d285c20::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL>(arg0, 6, b"POOL", b"SuiPool", b"SuiPool is an on-chain lottery platform built on the Sui blockchain, designed to deliver a fair, secure, and transparent experience. Every step, from purchasing tickets to announcing winners, is recorded on-chain and can be verified by anyone. The goal is to combine entertainment with technology, offering a simple and enjoyable experience for all users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxp7ta4mmwkfr23bjrtupby2yyn6bet6fqt2nfikv3cmvp4y4s2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

