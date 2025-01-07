module 0xc0b36162b45fbddda819c71b71b91b08d5c1335c63bd289e176a7c729de3981e::a16z {
    struct A16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: A16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A16Z>(arg0, 6, b"A16Z", b"AZ", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/memene.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A16Z>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

