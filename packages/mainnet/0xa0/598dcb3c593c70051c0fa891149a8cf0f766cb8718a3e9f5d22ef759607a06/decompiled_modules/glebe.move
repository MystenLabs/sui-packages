module 0xa0598dcb3c593c70051c0fa891149a8cf0f766cb8718a3e9f5d22ef759607a06::glebe {
    struct GLEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLEBE>(arg0, 6, b"GLEBE", b"Glebe coin", b"Glebe coin (Glebe)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Jnh_PH_7_Rur_Sp_J2_Bnoj_Z6_T8_Gm_Q2w_Ykv1ox8o3_H_Wak_SM_Wq_98ef9b42cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

