module 0xf0d8a522df6c042b6b11384e7b8799fc7d17df9d7d24f43185bc1e183d30c69b::loa {
    struct LOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOA>(arg0, 6, b"LOA", b"Law of Attraction", b"Spread the Law Of Attraction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1233_46324718c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

