module 0x829f88dc9096b9ddbf1c94e93b60c6a50c3f342274ffe2f94822de0d760d53eb::a16z1 {
    struct A16Z1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A16Z1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A16Z1>(arg0, 6, b"A16Z1", b"AZ1", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/memene.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A16Z1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A16Z1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

