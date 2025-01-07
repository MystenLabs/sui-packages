module 0x33ee8c6ebac5ab03012c9b7371ebf88fe7579c65e3443405d7d940ff18d33f70::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"HGH", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ken_Kaneki_9a3f669921.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

