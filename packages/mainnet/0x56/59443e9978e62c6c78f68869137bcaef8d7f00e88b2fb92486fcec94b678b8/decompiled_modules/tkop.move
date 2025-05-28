module 0x5659443e9978e62c6c78f68869137bcaef8d7f00e88b2fb92486fcec94b678b8::tkop {
    struct TKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKOP>(arg0, 6, b"TKOP", b"The King Of Pineapple", b"The King Of Pineapple who hold BTC for prosperity and wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic34aqcs7du6hnmpy7hh3btsuv6qxw6srbpg3hwwlhcdyt7ux5jz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TKOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

