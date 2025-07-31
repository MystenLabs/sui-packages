module 0xb72dc6ea867c1de63654aca8683046ce01cd2d034eb42665021bb5812f9a0b91::ikea {
    struct IKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKEA>(arg0, 6, b"IKEA", b"Not IKA", b"Sui drama just broke upper resistance and hit ATH. Join the pain train!!! TOOT TOOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic2cv5hktkvxfq7g57gttgwc5bzl75akr2mlj5vclduol4e3bzkui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IKEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

