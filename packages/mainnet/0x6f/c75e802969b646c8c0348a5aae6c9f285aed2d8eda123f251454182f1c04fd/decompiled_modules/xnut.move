module 0x6fc75e802969b646c8c0348a5aae6c9f285aed2d8eda123f251454182f1c04fd::xnut {
    struct XNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XNUT>(arg0, 6, b"XNUT", b"XNUT The Squirrel", x"584e55542054686520537175697272656c206f6e206d6f766570756d702e636f6d200a40656c6f6e6d75736b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdf_66c4f13c9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

