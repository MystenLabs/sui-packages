module 0x1f3a8ac6dc1538c66d523003f88e2d68199a5a4ac4de14f538cdf20fee98571e::blog {
    struct BLOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOG>(arg0, 6, b"Blog", b"Best loog", b"The Mars program has already begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013521_dba7c9ff13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

