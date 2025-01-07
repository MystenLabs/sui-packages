module 0x27466ecd8163b1bf0805e4d319a8aadb14535ac359d8ff38cb541a8d8c420282::bope {
    struct BOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPE>(arg0, 6, b"BOPE", b"Based Pope ($BOPE)", b"Father of Luce and ex husband of Nun Ya", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xo8xw_Wozepg2_Zz_Dn4_R_Gde5_NEML_Sk7rhf_EN_7e_Vev9_H8t_A_c9db4325a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

