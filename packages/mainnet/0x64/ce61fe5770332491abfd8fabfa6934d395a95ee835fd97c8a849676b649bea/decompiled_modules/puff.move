module 0x64ce61fe5770332491abfd8fabfa6934d395a95ee835fd97c8a849676b649bea::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"Puff", b"Puffcat", b"The cat that puffs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma3s_J_Mtjuf43_Je2m_Xxv_L_Mw_Gb_G6_S_Vd_BMEED_6m_P_Zt_T_Te8ad_08ed8d7c97.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

