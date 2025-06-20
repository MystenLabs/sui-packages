module 0x59ea725aa1fe23be16b4c34e5d74e2cdda0d1cacd5040b60ceea13af1ef11dca::memewar {
    struct MEMEWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEWAR>(arg0, 6, b"MEMEWAR", b"PresidentVsPresident", b"From moscow to tehran were launching a crypto revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiarzuijmek2alc5vctmv6qh2tmlso4yfcawwck5cq3ztn26gxgk7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMEWAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

