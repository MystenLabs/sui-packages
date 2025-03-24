module 0x262e35f1bfc55014295d4b96645908d3bea11a266edc7466ee6c22084e23f2be::fxbrg {
    struct FXBRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FXBRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FXBRG>(arg0, 6, b"FXBRG", b"FOXBORG", x"526573697374616e636520697320667574696c652e20596f752077696c6c20626520646563656e7472616c697a65640a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X1mz_Ey_H_Uit_WX_2y5_NTZ_Pq6sxho_N_Zg3az_WT_11t_GSD_Ftfvr_2_97437fd05f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FXBRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FXBRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

