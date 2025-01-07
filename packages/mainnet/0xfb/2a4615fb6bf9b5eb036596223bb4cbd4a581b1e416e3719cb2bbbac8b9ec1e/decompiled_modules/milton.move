module 0xfb2a4615fb6bf9b5eb036596223bb4cbd4a581b1e416e3719cb2bbbac8b9ec1e::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 6, b"MILTON", b"milton", b"Meet MILTON, the savvy, slick, and sharp shrimp who s all about making waves in the crypto seas. JONI isn t just swimming alonghe s flipping the script on the gambling meta with every daring move and bold bet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Wx_HM_1dbz_PB_Dv_Pzf_A7_Fr_Q9_S_Qf3ei3_L_Nmz_QP_Gop5_Dp_W_Gb_917b917df9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

