module 0xdd98063a58f426816e0a4841f7081883959445d133ae14fbd92de9e6cfa60b39::lll {
    struct LLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLL>(arg0, 6, b"LLL", b"Lazy Lunar Lad", b"Send lazy lunar lad to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreierbh3qyyr2me3bn6mz5ig3cl5u7u5qdqmdto3knlcq5ysbwho7pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

