module 0xc6bacbd4b4c231b626ca2955fdfde87b9f60e0b7b23288860e5f6c9c9b4fe603::fwogsui {
    struct FWOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGSUI>(arg0, 6, b"FWOGSUI", b"FWOG ON SUI", b"In the ashes a community emerged, a new flog, a more based flog, a FWOG FWOG has no dev. It is the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q4_H6_Y23d_S_Ejn9_LKB_85_M7_Kp_V_Fi_Du6_Kf_DNZ_Acrqi_Cw_FQQH_63306292f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

