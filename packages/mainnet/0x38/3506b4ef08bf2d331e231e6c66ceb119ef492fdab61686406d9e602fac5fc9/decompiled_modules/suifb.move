module 0x383506b4ef08bf2d331e231e6c66ceb119ef492fdab61686406d9e602fac5fc9::suifb {
    struct SUIFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFB>(arg0, 6, b"SuiFB", b"FacebookSui", b"FacebookSui: A memecoin with 100x potential. Strong community and growth opportunities ahead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_3d_render_of_a_visually_striking_digital_illustr_J_ZK_5_Yma_S_Ha_R_Pwa_MH_6m_P_Ww_1_O2urviq_Sg_St_TKRO_Rb05e_Q_ff8d602c53.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

