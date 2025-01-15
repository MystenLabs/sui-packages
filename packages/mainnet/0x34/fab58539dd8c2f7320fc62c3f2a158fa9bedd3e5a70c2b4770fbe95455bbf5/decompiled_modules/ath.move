module 0x34fab58539dd8c2f7320fc62c3f2a158fa9bedd3e5a70c2b4770fbe95455bbf5::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"American Trump Hero", x"416d65726963616e205472756d70204865726f2c206973206261636b21204f6e204a616e7561727920323074682c2068652074616b657320746865206f61746820617320507265736964656e742c206861696c656420627920416d65726963616e7320617320746865697220736176696f722e202441544820686f6e6f72696e67205472756d7020616e642061696d696e6720666f7220616e20416c6c2054696d6520486967682e204c657473206d616b652063727970746f20677265617420616761696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcg_Fo4xmquifp_Q8p_WBZ_Mv_L_Hum_Mexz_B6j_A1s_Qw_K2_V_Wc_Vx_G_0b2a1e56bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

