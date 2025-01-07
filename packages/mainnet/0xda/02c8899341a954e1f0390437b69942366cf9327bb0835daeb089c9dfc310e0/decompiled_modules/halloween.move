module 0xda02c8899341a954e1f0390437b69942366cf9327bb0835daeb089c9dfc310e0::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 6, b"HALLOWEEN", b"Happy Halloween", x"48617070792068616c6c6f7765656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Wz2g_Lu_HW_53_BK_6_P_Pq_Mm_Ji_LN_Uxtr_P_Df_L_Sp8_ZVN_4jp8e_N5_52b327020c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

