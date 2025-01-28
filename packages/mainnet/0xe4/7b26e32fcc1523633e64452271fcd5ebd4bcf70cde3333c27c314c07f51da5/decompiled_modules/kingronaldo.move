module 0xe47b26e32fcc1523633e64452271fcd5ebd4bcf70cde3333c27c314c07f51da5::kingronaldo {
    struct KINGRONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGRONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGRONALDO>(arg0, 6, b"KingRonaldo", b"Cristiano Ronaldo", b"King Ronaldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059783_491089219c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGRONALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGRONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

