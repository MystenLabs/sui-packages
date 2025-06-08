module 0x1e23e826d80ba22b5c754ddc371a0a0c4b914b8ca77a6eb697c619a5ce8ddf48::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 6, b"BUL", b"BLU BUL", b"Are u feelings bullish?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4l4evmwi2gwu4vv6vonumf3f65gpertssv5tlvljq5ve4o624o4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

