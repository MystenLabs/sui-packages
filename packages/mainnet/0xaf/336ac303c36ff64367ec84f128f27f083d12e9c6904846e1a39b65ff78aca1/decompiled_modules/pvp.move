module 0xaf336ac303c36ff64367ec84f128f27f083d12e9c6904846e1a39b65ff78aca1::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 6, b"PVP", b"penguin vs penguin", b"stop the pvp niggas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ncr_Uzj6_Nm_Za8_NE_Afh4_Vv_Yr_A_Dw_SDW_Eg_Xygyj_D_Uai7m_S_Sj_46b3a6160e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

