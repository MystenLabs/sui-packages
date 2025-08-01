module 0xd24f91afb69ea4479ba65b7a67c4a9143cd169cdf997f5217d3807124097c0c5::future {
    struct FUTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTURE>(arg0, 6, b"FUTURE", b"Future Coin", b"Future Coin emerges as more than just another cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif3sdml5ksxewjlwfxccnuzoauk4aw64kd4zec4qi6vemetpmdohy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUTURE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

