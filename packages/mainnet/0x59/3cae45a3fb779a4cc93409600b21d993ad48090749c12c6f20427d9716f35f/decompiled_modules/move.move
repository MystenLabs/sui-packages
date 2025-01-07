module 0x593cae45a3fb779a4cc93409600b21d993ad48090749c12c6f20427d9716f35f::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 6, b"MOVE", b"Move Pump", x"4d6f76652050756d700a0a5468652042657374204d656d652046616972204c61756e636820506c6174666f726d206f6e204d4f5645", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOVE_13f2de921c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

