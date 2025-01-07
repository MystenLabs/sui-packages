module 0xc7c00fcf7b2c342107cf4978b1beca0f17d03071c791ff7cf2d693b37d5c5f53::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"BOG THE FROG", x"424f47204f4e205355490a54473a2068747470733a2f2f742e6d652f626f676f6e7375690a205765623a20536f6f6e0a20583a2068747470733a2f2f782e636f6d2f626f676f6e7375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054711_e00240dcf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

