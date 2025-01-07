module 0x38b427001c6d8b8dfb4d7877c3a6fabb9522479f230a60a893304edd2944ea93::blog {
    struct BLOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOG>(arg0, 6, b"Blog", b"Bloog", b"The Mars program has begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013521_1c3aee9e7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

