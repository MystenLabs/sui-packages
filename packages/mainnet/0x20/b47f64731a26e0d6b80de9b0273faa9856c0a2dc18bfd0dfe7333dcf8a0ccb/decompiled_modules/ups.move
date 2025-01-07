module 0x20b47f64731a26e0d6b80de9b0273faa9856c0a2dc18bfd0dfe7333dcf8a0ccb::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPS>(arg0, 6, b"UPS", b"Under Pressure Sendor", x"41206c6f74206f6620707265737375726520627574206865207374696c6c2073656e64730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_We_Uu2k_Nw_D_Qp7_Fi_H7c79a_Xdq_Rr_X_Fz_F_Wopv_Y_Ng_N_Sitw5_Zr_1_08cbc2e7a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

