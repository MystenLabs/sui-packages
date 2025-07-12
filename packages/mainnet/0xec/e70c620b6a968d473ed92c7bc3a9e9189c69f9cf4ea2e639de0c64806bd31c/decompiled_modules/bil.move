module 0xece70c620b6a968d473ed92c7bc3a9e9189c69f9cf4ea2e639de0c64806bd31c::bil {
    struct BIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIL>(arg0, 6, b"BIL", b"billy", b"THE BEST BIL IN TOWN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihqc4dwpayakhxkpoujdejawwkm7it2rnhw5dqewdz7fu2e6nhqgu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

