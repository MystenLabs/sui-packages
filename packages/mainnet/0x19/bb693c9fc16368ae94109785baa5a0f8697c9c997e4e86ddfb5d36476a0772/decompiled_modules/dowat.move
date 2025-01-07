module 0x19bb693c9fc16368ae94109785baa5a0f8697c9c997e4e86ddfb5d36476a0772::dowat {
    struct DOWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWAT>(arg0, 6, b"DOWAT", b"Dog with watermelon", b"Who wore it better? Obviously, me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/db2ef5a86e6c85f377d383d453f290c7_1741bbab2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

