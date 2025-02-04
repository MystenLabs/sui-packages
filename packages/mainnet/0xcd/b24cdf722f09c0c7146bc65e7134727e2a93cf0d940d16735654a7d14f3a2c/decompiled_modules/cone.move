module 0xcdb24cdf722f09c0c7146bc65e7134727e2a93cf0d940d16735654a7d14f3a2c::cone {
    struct CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONE>(arg0, 6, b"CONE", b"Cone Cat", b"Just a cat in a cone after surgery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017412_7e83a3c4ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

