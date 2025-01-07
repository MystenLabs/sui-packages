module 0x2e2a8dc4db998241f85b928c164c7d85f57b9f1e3b08e18accad68ebc2cd6791::stckr {
    struct STCKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STCKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STCKR>(arg0, 6, b"STCKR", b"STICKER", x"535449434b4552202d20535449434b4552200a0a535449434b4552202d20535449434b4552200a0a535449434b4552202d20535449434b4552200a0a535449434b4552202d20535449434b455220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rr8_HPNC_4_YV_Sb5m_Dde2_Sv_Jgt_J_Hn9vtxj_Yqe_Vc_Kub_Hz_LBG_63ced53351.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STCKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STCKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

