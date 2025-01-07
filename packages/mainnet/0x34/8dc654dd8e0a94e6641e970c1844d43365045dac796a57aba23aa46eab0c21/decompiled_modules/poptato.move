module 0x348dc654dd8e0a94e6641e970c1844d43365045dac796a57aba23aa46eab0c21::poptato {
    struct POPTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTATO>(arg0, 6, b"Poptato", b"Poptato sui", x"4120706f7070696e6720506f7461746f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WY_1_N_Lp_L_Uuo9_Js_P_Cg7m_Dn9o_Ymu3bf_Jy_Cq_SP_2_KAT_2_J9c_Tw_71ba1379c3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

