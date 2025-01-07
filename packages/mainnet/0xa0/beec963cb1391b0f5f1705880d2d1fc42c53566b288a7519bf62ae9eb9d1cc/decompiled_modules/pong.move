module 0xa0beec963cb1391b0f5f1705880d2d1fc42c53566b288a7519bf62ae9eb9d1cc::pong {
    struct PONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONG>(arg0, 6, b"PONG", b"Pingpong SUI", b"$PONG $PONG $PONG $PONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e486e12a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

