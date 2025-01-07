module 0x89222e93a5a5d05c7338652a0f9760e911216b34a21e0777faf413062712d03a::greedy {
    struct GREEDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEDY>(arg0, 6, b"GREEDY", b"GREEDYSUI", b"$GREEDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xpmwm_VXK_2_L8_Txh_EJ_Wj_Yf_Wy_Sj3a_J8m_RW_Ne_Tp_EW_Pj2ps_Rq_0fe61e607f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

