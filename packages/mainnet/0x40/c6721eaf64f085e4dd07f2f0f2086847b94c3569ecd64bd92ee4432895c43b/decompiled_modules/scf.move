module 0x40c6721eaf64f085e4dd07f2f0f2086847b94c3569ecd64bd92ee4432895c43b::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Sui Chicken Fish", b"He who holds is richer than he who sold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zj_Asjt_X_Ec3_RPT_Fch1_Mf_Mh_QS_Xrv_M7m_PS_Gmyrwj_Qke_U_Ap_R_c18036412e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

