module 0xb6f73e338e9be9e9f028584a549fb1b9f4fbf424f91366323d94cd1c738e2334::movedeng {
    struct MOVEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDENG>(arg0, 6, b"MOVEDENG", b"MoveDeng", b"Just a viral lil' hippo riding the power of Move language on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Move_Deng_c4c905bca7_5608bbb486.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

