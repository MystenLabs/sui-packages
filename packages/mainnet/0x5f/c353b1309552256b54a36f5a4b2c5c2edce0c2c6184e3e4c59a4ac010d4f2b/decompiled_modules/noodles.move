module 0x5fc353b1309552256b54a36f5a4b2c5c2edce0c2c6184e3e4c59a4ac010d4f2b::noodles {
    struct NOODLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLES>(arg0, 6, b"NOODLES", b"Noodles Fi", b"The no-brainer trading platform for Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6rfxjjtmcmtx6d3rs2tebdbl2u2x5otodrntl6vyhrecaurznei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOODLES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

