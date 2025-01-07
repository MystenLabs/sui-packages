module 0x430f7f1da219941bf01362329de391ec5db6beaae366fa5ea535126d0c9edd1e::a4 {
    struct A4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A4>(arg0, 6, b"A4", b"Paper", b"Take a pencil in your hand and write down all your deepest wishes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_aba4329459.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A4>>(v1);
    }

    // decompiled from Move bytecode v6
}

