module 0x16c7d5d52e58f7755d23a6d0cd5b0958662423d398eea630440ceec7e9e7c8b6::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"Ttt", b"Test", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicedklbtznaoanjukcwqfn4dx4vsllyr6mysyxluhwbr7pzk2qyt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

