module 0x246c6acff5ffd94c27dd3a56f8c0dc168ae8529fcc835f6074897fd98ce40a46::egs {
    struct EGS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EGS>, arg1: 0x2::coin::Coin<EGS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<EGS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EGS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EGS>>(0x2::coin::mint<EGS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGS>(arg0, 9, b"EGS", b"Eagle Sui", b"EGS is the second meme coin in the Sui ecosystem with a self burning model,using PanS as its liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihuu264fe5f6nun3k4mfj5cwag5g5y3ij4an7zvlenhqfpteksqre?filename=egs.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

