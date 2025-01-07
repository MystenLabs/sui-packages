module 0x30fac86c9e2c715862f3372b20ac30d641a17efefa451642dca1b12552db8b6f::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"SUI FWOG", b"In the ashes a community emerged, a new flog, a more based flog, a FWOG FWOG has no dev. It is the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q4_H6_Y23d_S_Ejn9_LKB_85_M7_Kp_V_Fi_Du6_Kf_DNZ_Acrqi_Cw_FQQH_ee5b645cff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

