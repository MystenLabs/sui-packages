module 0x788115398530e1064bc15b447953dce23f34e81863a9e6cedd88d4b58bd24c21::supadeng {
    struct SUPADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPADENG>(arg0, 6, b"SUPADENG", b"supadeng", x"6d6f6f64656e67206973206e6f77207375706164656e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbx_R_Zd_Mad_B5v1h_A18_Tz9_MP_79yja_MY_Shw_XT_3f_W_Sb_Qum2_Y5_a9d05a72ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

