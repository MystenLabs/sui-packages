module 0xc2fa1765bdfd6a0b1fb7d06ef565a3b305cae44f07c8f7b5f9c6100d54eb21b4::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Effen Cheng", b"Hi guise im Effen Cheng. As i alwys sey you cant spell SWEET without SUI. Also i wear glasses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/founder_52f1644bd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

