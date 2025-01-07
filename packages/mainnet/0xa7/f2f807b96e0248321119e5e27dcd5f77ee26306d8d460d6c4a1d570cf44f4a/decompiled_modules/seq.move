module 0xa7f2f807b96e0248321119e5e27dcd5f77ee26306d8d460d6c4a1d570cf44f4a::seq {
    struct SEQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEQ>(arg0, 9, b"SEQ", b"SeqCore AI", b"SeqCore: decentralized AI network, blockchain-powered, AI agents training data, $SEQ token rewards, decentralized AI learning Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ1zMyP6akvNDMtB5x5RygUhPE824cCVkoZbwSKWSvkw5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEQ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

