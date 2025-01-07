module 0x6730d24340f59a97ecdc310b8d0088e0ca2e30224ea4598970a330fb6743d3a1::dogecast {
    struct DOGECAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECAST>(arg0, 6, b"DOGECAST", b"Dogecast", b"Elon Musk and Vivek Ramaswamy livetream every week to update the American public of @DOGE's progress.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SDJ_74_Lm_D6_YG_9_H1a_L_Vg_FFH_Pn_X81_Fap_P_Qz9ko_CE_2ad94_V1_030ad01ce3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

