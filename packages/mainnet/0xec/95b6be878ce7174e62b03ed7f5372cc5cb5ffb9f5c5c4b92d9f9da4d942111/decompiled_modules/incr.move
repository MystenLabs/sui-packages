module 0xec95b6be878ce7174e62b03ed7f5372cc5cb5ffb9f5c5c4b92d9f9da4d942111::incr {
    struct INCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INCR>(arg0, 6, b"Incr", b"Kouze", b"Mon dentiste a vu la difference.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71_E_Jdhy_Q_Ik_L_bea2de1a55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

