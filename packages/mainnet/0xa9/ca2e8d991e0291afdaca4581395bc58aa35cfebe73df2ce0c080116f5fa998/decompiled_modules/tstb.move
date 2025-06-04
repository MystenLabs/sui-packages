module 0xa9ca2e8d991e0291afdaca4581395bc58aa35cfebe73df2ce0c080116f5fa998::tstb {
    struct TSTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTB>(arg0, 6, b"TSTB", b"TEST DONT BUY PLS", b"DONTBUYYYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmdb36yjulfiviltcjijhsw45wl73jddtp343fkn2uc3sp2223sq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

