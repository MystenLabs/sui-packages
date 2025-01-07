module 0x4fc6f7c46539b8a03717ebdcef053b025d7d6a0d4b63910345e2209a9abc29af::famguy {
    struct FAMGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMGUY>(arg0, 6, b"FAMGUY", b"FAMILY GUY", x"68747470733a2f2f66616d6775792e78797a2f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V_Nphe9_Rvw_Mg3_Xy_RL_Sizu_At_H_En_Kp_Zf_Q_Mk_XJXPB_Rgz_TD_1u_43039bb578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

