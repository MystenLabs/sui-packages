module 0x6608e38f1c9a10f4eb4c20a8b8c421c0487ff3b003c82cd1bf44082927a1b9df::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"fwog", b"ust a lil fwog in a big pond ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rc_QM_35_Na_Cny6_Rd_Q_Ye_Zcc_S_Nr1n_Lrdv_TAX_4m_Tdhfu53_Lz_Z_56cda4abbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

