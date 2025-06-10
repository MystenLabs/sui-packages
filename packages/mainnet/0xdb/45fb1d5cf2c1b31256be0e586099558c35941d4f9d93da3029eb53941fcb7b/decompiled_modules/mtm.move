module 0xdb45fb1d5cf2c1b31256be0e586099558c35941d4f9d93da3029eb53941fcb7b::mtm {
    struct MTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTM>(arg0, 6, b"MTM", b"Metamon", b"A Sui NFT Marketplace featuring different Metamonsters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv3tinwu3uyz7we4mqaxjcv4hoigq5xkzoyboajap5zwouzuvlei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

