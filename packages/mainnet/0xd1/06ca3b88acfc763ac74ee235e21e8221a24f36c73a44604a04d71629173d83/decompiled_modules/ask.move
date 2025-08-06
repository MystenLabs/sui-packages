module 0xd106ca3b88acfc763ac74ee235e21e8221a24f36c73a44604a04d71629173d83::ask {
    struct ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASK>(arg0, 6, b"ASK", b"ASIK", b"MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigk4sdz4jngb4y4nqo6jynl4qdkhrewlv2n73ej2q6xlrijiexa2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

