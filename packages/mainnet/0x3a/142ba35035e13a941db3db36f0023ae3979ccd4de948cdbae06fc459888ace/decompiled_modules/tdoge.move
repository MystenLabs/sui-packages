module 0x3a142ba35035e13a941db3db36f0023ae3979ccd4de948cdbae06fc459888ace::tdoge {
    struct TDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOGE>(arg0, 6, b"TDoge", b"TrexDoge", b"$TDoge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yd_B_Ywa_EMT_2t_Wys_An9_Be_MA_Nf_M4nwq_C8m_Kg_Nfk_Lq_Ewf_H_Zq_14a06e4eb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

