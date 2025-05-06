module 0xf501c608421721c1b49f17f461f5b2290f90c6a4d2c78db603000a94834d839e::crc {
    struct CRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRC>(arg0, 6, b"CRC", b"OnlyOneCRC", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictsy6catkkgyz7gnwvqadov2fuskmctbe4dagqubgw2wwpt2wy24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

