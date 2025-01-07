module 0xcb7023d3efc55452225c7e042745cabba0d43be0631b02f31a3b27216fcb0f50::aipowered {
    struct AIPOWERED has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPOWERED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPOWERED>(arg0, 6, b"AIPowered", b"SUIAIPowered", b"AIPowered.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wev5_Ku5yocn8f_WBJ_54_G_Ux_Jv_T_Nqws_J_Kd_H7e3enoe_Crz_QH_94b3bb89eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPOWERED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPOWERED>>(v1);
    }

    // decompiled from Move bytecode v6
}

