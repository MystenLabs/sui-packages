module 0xd4f71c52071cdbc970521f5d8e41b84327a6e580b1d2a711cb5be262dfa4dbea::triangle {
    struct TRIANGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIANGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIANGLE>(arg0, 6, b"TRIANGLE", b"Dancing Triangle on SUI", b"Dancing Triangle isnt really regular memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dancing_triangle_042a5abe48.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIANGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIANGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

