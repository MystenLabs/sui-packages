module 0xdb6f52dc7d7704c0f437448ccf6784a7295d08cd9ebe5ce9ba3fdd0ae23d3fc7::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"DUCKY", b"DuckyDuck", b"Ducky the secret fren of Pepe, Andy, Brett, and Landwolf | Part of Matt Furie's Boys Club legacy $DUCKY | Just Duck it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DE_8_N_Nks_D5m3_Kd4oh_J_Az_Tw_JH_Lss9zb_Xd_N_Ueg_Eo_L4_Qx_D4_C_30fef4dbf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

