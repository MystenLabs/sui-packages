module 0xded7bc3d87290080c09357d34b4593392a8a32ff20db5ef0140d2a8dee5d64fe::test6 {
    struct TEST6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST6>(arg0, 6, b"TEST6", b"TEST TOKEN 6", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif2zj7yuzg4khj5tg7t3b7uhepbucnixkqjt4odsck3hzhrwwmv7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST6>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

