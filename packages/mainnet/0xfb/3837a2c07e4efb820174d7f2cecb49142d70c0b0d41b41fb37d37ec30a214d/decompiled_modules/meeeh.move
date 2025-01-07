module 0xfb3837a2c07e4efb820174d7f2cecb49142d70c0b0d41b41fb37d37ec30a214d::meeeh {
    struct MEEEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEEH>(arg0, 6, b"MEEEH", b"MEEEH SEAL", b"MEEEH is a sound of cute baby seal, this token not owned by any entities, no tg, no twitter, no website, you love it ? buy it, you want it pump ? CTO it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/freepik_edit_A_young_fluffy_super_cute_like_circle_baby_white_s_e5ab73ca8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEEEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

