module 0x3b74c0e518cdefc456e3d4ac03b1b310c94113aa36e20186a573e780bc242812::muugnet {
    struct MUUGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUUGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUUGNET>(arg0, 6, b"MUUGNET", b"Muugnet", b"dis is a muugnet. ahh fuk my brain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TZU_3xq_Zu_Y_Frri5_Sm_SZSH_Uqy_U_Am_P_Nq_V9_Jb_Ax_HBUC_Pbcv8_89f250833c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUUGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUUGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

