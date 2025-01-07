module 0xe4fb8b24209c1bae75fd216e6f0f3ec2f419f6d414415d6ae8d98c47ab6331b8::fbsui {
    struct FBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBSUI>(arg0, 6, b"FBSui", b"FacebookSui", b"FacebookSui: A memecoin with 100x potential. Strong community and growth opportunities ahead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_3d_render_of_a_visually_striking_digital_illustr_J_ZK_5_Yma_S_Ha_R_Pwa_MH_6m_P_Ww_1_O2urviq_Sg_St_TKRO_Rb05e_Q_1ba4d82967.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

