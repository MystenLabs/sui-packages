module 0xf6e0fa9b500cf10a321a1da859e08b8777b682d91b52d50a6ccf847370685fd6::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puffcat", x"5468652063617420746861742070756666730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma3s_J_Mtjuf43_Je2m_Xxv_L_Mw_Gb_G6_S_Vd_BMEED_6m_P_Zt_T_Te8ad_082b6b2c9d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

