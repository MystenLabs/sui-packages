module 0x352f5f031848d075ab2b45086c4225c1b45b75a681b40f39b96d0d4222e384d::greens {
    struct GREENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENS>(arg0, 6, b"GREENS", b"The Greens", b"Are you ready for  The Greens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023366_96825e9340.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

