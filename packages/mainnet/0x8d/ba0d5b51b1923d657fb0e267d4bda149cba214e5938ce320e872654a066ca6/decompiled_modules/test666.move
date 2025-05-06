module 0x8dba0d5b51b1923d657fb0e267d4bda149cba214e5938ce320e872654a066ca6::test666 {
    struct TEST666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST666>(arg0, 6, b"Test666", b"Test", b"Test666 don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibwf3rbgofqwjz4mm232vukvysocpyy6teq53wy5v2h6ogql3farq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST666>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

