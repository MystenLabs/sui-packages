module 0x589daec7bd036b344f9bfdc16bb383be3dbe66f47b409aed9f4f2bc3ebe76518::elfjak {
    struct ELFJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELFJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELFJAK>(arg0, 6, b"ELFJAK", b"Elfjak", x"4a616b20686173207475726e656420696e746f20616e20456c6620666f7220746865204368726973746d617320736561736f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VU_8tu_Y_Nh4_T_Ahs_LDRU_7o_Z6p_Nj_XY_9_NN_9_L_Kq_JL_Zoqy_Ezi_GG_0ff3119a6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELFJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELFJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

