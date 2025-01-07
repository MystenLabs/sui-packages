module 0xda4e7c3f31e0f832e135e950e1368f4f2469c442f2c89e653323a2e396a78bfa::gil {
    struct GIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIL>(arg0, 6, b"GIL", b"kith gil", x"2467696c206973206120537569206d656d65636f696e20746861742068756d6f726f75736c79207265666572656e636573204b656974682047696c6c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xp_Ug_HJ_5o_400x400_464fdea1d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

