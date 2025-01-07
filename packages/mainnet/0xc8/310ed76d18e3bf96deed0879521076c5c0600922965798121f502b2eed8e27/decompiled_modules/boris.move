module 0xc8310ed76d18e3bf96deed0879521076c5c0600922965798121f502b2eed8e27::boris {
    struct BORIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORIS>(arg0, 6, b"BORIS", b"BORIS FROM NOTHING", b"I'm Boris - a drug dealer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ag_AC_Ag_UA_Axk_BAAGO_Dxxnae1ws6_Db_Va_NU_89gn_TL_Vl_Lbhmj_AA_Cy8_Qx_G9_Bc_U_Ve_iz10_Fygf8_QEA_Aw_IAA_3g_A_Az_YE_071a62421b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

