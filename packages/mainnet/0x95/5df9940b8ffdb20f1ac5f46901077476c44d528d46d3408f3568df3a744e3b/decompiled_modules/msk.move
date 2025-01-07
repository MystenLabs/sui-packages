module 0x955df9940b8ffdb20f1ac5f46901077476c44d528d46d3408f3568df3a744e3b::msk {
    struct MSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSK>(arg0, 6, b"MSK", b"mask", b"Sign up Now: blueprint101.scoreapp.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006835_7636e95bb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

