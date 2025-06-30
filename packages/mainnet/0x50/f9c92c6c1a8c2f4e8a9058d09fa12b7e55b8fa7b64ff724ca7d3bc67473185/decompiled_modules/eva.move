module 0x50f9c92c6c1a8c2f4e8a9058d09fa12b7e55b8fa7b64ff724ca7d3bc67473185::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 6, b"EVA", b"Eva Online", x"53656e7469656e742070726f746f636f6c0a6f6273657276696e672068756d616e20636f6c6c61707365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiddlsjusdop5u7cduppun7kthx4gu6iflemrrahesu3te47qzsfny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

