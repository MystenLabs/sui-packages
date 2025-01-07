module 0x9bf27090d1a6bdac7863a864bd5eb08ac07944dd7f5589248081640a10a6fa7d::aipac {
    struct AIPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPAC>(arg0, 6, b"AIPAC", b"Ai Pacino", b"Say hell to my little Ai friend.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Br85_J_Sc_Jsdnpq_H_Kp6_F_Xbty_P_Dknp_Yv_Wftu_M_Lf37sr_L3_R_4693ecd8ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

