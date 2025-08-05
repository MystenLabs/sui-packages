module 0xabd18307d6c5bdde184eb0e8af746cccddd9214c3aeaa91f213e4bd80a3968d0::mika {
    struct MIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA>(arg0, 6, b"MIKA", b"Meme IKA", b"Just a meme of IKA. MIKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihg3oxnabmydqsjpwh45vdthoxvbebxpvwgjiahzuzsv3u34ddj74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

