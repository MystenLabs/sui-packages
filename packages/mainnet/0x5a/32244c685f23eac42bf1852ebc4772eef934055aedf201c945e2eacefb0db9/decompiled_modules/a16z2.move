module 0x5a32244c685f23eac42bf1852ebc4772eef934055aedf201c945e2eacefb0db9::a16z2 {
    struct A16Z2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A16Z2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A16Z2>(arg0, 6, b"A16Z2", b"AZ2", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/memene.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A16Z2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A16Z2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

