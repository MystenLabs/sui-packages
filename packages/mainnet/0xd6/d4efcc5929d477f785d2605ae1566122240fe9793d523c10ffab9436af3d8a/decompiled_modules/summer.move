module 0xd6d4efcc5929d477f785d2605ae1566122240fe9793d523c10ffab9436af3d8a::summer {
    struct SUMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMER>(arg0, 6, b"Summer", b"Sui Summer", x"4e6f20536f6369616c732e204e6f2043656c65627269746965732e204e6f2050726f6d697365732e0a0a42757920736f6d6520616e6420676f20656e6a6f79205375692053756d6d65722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibbmjbgtdol3pmk6buyyg3hcuy4mf5nlxzfyxqcnhlntav4ysvzfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMMER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

