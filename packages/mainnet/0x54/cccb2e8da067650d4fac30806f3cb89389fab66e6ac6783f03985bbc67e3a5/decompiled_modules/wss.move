module 0x54cccb2e8da067650d4fac30806f3cb89389fab66e6ac6783f03985bbc67e3a5::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 6, b"WSS", b"Wall Street Sui", b"The future of finance runs on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwc55gerifzlph5x2l3f7d4gqwvc6gckt7vaznf6ek4ujf5x6ovi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

