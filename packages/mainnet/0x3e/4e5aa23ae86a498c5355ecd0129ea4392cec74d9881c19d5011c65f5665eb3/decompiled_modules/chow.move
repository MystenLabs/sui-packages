module 0x3e4e5aa23ae86a498c5355ecd0129ea4392cec74d9881c19d5011c65f5665eb3::chow {
    struct CHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOW>(arg0, 6, b"CHOW", b"CHOW CHOW", b"CHOW CHOW CHOW ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QT_Mb_EA_Tr_H_Mjv_YR_6ik_HTKW_Yg_Sgcp_TVN_Xp_Cu_CE_Hi_B_Dx_Znx_6ddeb97b76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

