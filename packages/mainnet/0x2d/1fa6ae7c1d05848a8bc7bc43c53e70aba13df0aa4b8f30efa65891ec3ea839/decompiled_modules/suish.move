module 0x2d1fa6ae7c1d05848a8bc7bc43c53e70aba13df0aa4b8f30efa65891ec3ea839::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"Suish", b"Susihi", b"Welcome to SUISHI!! Only chads can eat me, there are no seats for jeets at this buffet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishi_5a9f82e444.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

