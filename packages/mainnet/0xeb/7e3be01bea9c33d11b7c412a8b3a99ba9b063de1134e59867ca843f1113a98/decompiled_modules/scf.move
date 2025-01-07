module 0xeb7e3be01bea9c33d11b7c412a8b3a99ba9b063de1134e59867ca843f1113a98::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Smoking Chicken Fish", b"He who holds shall be richer than he who has sold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zj_Asjt_X_Ec3_RPT_Fch1_Mf_Mh_QS_Xrv_M7m_PS_Gmyrwj_Qke_U_Ap_R_46eb4de7d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

