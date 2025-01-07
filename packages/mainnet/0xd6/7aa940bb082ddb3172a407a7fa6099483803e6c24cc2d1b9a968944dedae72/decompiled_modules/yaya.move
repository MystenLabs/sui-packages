module 0xd67aa940bb082ddb3172a407a7fa6099483803e6c24cc2d1b9a968944dedae72::yaya {
    struct YAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAYA>(arg0, 6, b"YAYA", b"yaya cat", b"YaaaaaaaAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S64_X_Ki_V77s_K_Cx_EAUY_Yif5rk2g2_L6z_AM_8_Hk_NX_Puu_K7g1_Y_5bd385d9fe.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

