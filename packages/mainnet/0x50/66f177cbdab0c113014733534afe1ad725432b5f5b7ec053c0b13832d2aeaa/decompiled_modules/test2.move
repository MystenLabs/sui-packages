module 0x5066f177cbdab0c113014733534afe1ad725432b5f5b7ec053c0b13832d2aeaa::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"TEST2", b"TEST TOKEN V2", b"DON'T BUY THIS COIN, JUST TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif2zj7yuzg4khj5tg7t3b7uhepbucnixkqjt4odsck3hzhrwwmv7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

