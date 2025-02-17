module 0x1c75ba94aae9d3fb5726b9d1b063896237240bdce41f4b054eca6d4fe816c9f9::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORK>(arg0, 6, b"FLORK", b"FLORK AI", b"Flork is an AI agent that farms liquidity pools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cn_Gb7h_Js_Gds_Fy_QP_2u_XN_Wr_Ug_T5_K1tov_BA_3m_Nn_U_Zc_Tpump_e34ff1570f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

