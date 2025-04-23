module 0x82e02187fba6dc6c9c9093a3a66ee783ef4aeabcacaa9e40eca4b41023765372::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 6, b"Cb", b"Cannabis", b"Your helping friend, to get you through those hard day's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifa2ssinweah3ldgwihtwuu5bwhu653k3h7lca5j7yzbkq6u5b4ge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

