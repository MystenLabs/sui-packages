module 0x7c0c268bfb199c28541608ce529429493f71bb95547f41cb4dfecf7d20bb9b8b::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"bobo", x"4d6565742024424f424f2020746865206c6974746c6520626c75652067686f7374207769746820612062696720686561727421200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pi_Qkak_WT_4_Qig_Zx_Ga_Q7p_S_Fvh_J7i_P_Qj3h_M3y1_Lj7d_RG_4en_c776739490.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

