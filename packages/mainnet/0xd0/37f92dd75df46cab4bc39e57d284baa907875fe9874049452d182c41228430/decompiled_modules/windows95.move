module 0xd037f92dd75df46cab4bc39e57d284baa907875fe9874049452d182c41228430::windows95 {
    struct WINDOWS95 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDOWS95, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDOWS95>(arg0, 6, b"Windows95", b"Windows 95", x"46494e4420594f55522057494e444f575339350a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ns3_Vez_R_Lus_Mw_Cx_Jco_Gz_Niv98_N_Sp_TY_Ru_V_Qb_M_Bm_D2cmrom_17ee5b9016.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDOWS95>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINDOWS95>>(v1);
    }

    // decompiled from Move bytecode v6
}

