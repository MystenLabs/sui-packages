module 0x6a8ee5408a6755314f3fcd5a917ad8a4e1b72405e7db171b0862e78845f57e0f::gum {
    struct GUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUM>(arg0, 6, b"GUM", b"Gumball", b"Gumball  to the sun lets do it rocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAAAB_Wogdk1e_Sk_SW_9_GYG_bzn_D3y_RM_7uvrd_T3w_Snnv_D_SO_Qi1f_A_Da_Jqwyw_Ux_U1_J_Xka_OXE_Gx5jgjv1_V4_Z_Pd_D0_Im_umb_Iaz5_F_X_Mz_K0_H_8995637fc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

