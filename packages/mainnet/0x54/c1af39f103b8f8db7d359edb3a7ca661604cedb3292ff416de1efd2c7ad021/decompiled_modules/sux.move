module 0x54c1af39f103b8f8db7d359edb3a7ca661604cedb3292ff416de1efd2c7ad021::sux {
    struct SUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUX>(arg0, 6, b"SUX", b"Hop aggrevator", b"Just reload it and it will work never!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8876_8498304718.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

