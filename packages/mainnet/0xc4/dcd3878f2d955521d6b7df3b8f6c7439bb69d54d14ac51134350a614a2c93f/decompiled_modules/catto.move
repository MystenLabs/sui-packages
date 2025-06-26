module 0xc4dcd3878f2d955521d6b7df3b8f6c7439bb69d54d14ac51134350a614a2c93f::catto {
    struct CATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTO>(arg0, 6, b"CATTO", b"THUGCATTO", b"THUGCATTOTHUGCATTOTHUGCATTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifcyt2vkt2565dbpgtrarfclgk44ohfs3nqlb7c6a2g6dsoq4ause")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

