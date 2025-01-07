module 0x5d2d67b2459a389e71454d80bd3f26435f1d7b90c0cef3715dc85bf1071830fa::sastral {
    struct SASTRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASTRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASTRAL>(arg0, 6, b"Sastral", b"Astral", b"Going far in astral travel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfdfsdfsdf_b1f00b47fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASTRAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASTRAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

