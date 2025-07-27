module 0xa6f7ee4dc51b67280a7d186582aac0f00e7ce15f71bc639b005ea1a63a1be7e7::cena {
    struct CENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CENA>(arg0, 6, b"CENA", b"John Cena on SUI", b"This token is just a celebration as JOHN CENA followed me! What if he retweeted?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiboxuja7xfbdnmbozbb6xjhl65gu7twv6xyimalgfafltf2yknuqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CENA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

