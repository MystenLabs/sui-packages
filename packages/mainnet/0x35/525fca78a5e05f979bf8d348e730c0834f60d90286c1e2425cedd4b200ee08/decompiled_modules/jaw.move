module 0x35525fca78a5e05f979bf8d348e730c0834f60d90286c1e2425cedd4b200ee08::jaw {
    struct JAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAW>(arg0, 6, b"JAW", b"Jaw The Shark", b"A big baby shark in a liquid ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ag_AC_Ag_EA_Axk_BAAF_91_Stn_Zuldz9m_On_OB_Xf_HH_4_SM_Yeu_Vji1_AAC_Ya4x_Gwj_VO_Uc_Yu5_XG_48_Ct_OAEA_Aw_IAA_3k_A_Az_YE_85feb3caad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

