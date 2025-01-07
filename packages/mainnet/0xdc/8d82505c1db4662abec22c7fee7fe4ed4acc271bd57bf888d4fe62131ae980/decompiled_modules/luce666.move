module 0xdc8d82505c1db4662abec22c7fee7fe4ed4acc271bd57bf888d4fe62131ae980::luce666 {
    struct LUCE666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE666>(arg0, 6, b"LUCE666", b"TheAntiLUCE", x"54686520416e74692d4c7563652028244c554345363636292e20486572616c64206f6620746865204d6f726e696e6720537461722e20416c6c204861696c2074686520477265617420446566696c65722e2054686520456e64206f66204d656d65732068617320636f6d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_CD_7_P2_B3_Tr_V_Ep_S_Sm_Az_G8qh_K_Sa_Hm_Mn_U_Rt_S_Ws_Fk73iarb_R_6f70e6933e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCE666>>(v1);
    }

    // decompiled from Move bytecode v6
}

