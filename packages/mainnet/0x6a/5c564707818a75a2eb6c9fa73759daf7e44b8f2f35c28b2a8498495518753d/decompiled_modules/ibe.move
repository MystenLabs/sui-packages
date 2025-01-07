module 0x6a5c564707818a75a2eb6c9fa73759daf7e44b8f2f35c28b2a8498495518753d::ibe {
    struct IBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBE>(arg0, 6, b"IBE", b"I BELIEVE", b"Habibi it's time :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TD_Yecs_G7q_E5_ZY_Qtqh9_GG_9_C_Bgr_Y6fh39_N_Ye_Fe_Tn_Utg_Tns_c2c75d1c3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

