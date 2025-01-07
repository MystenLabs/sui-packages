module 0xf655e38bcbf69a72f741429ef4e41ee32fffd8454b09801ea44e1a326aaae447::alris {
    struct ALRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALRIS>(arg0, 6, b"ALRIS", b"alris", b"A On-Chain Trader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S96x_Lmpu_M1_Wq1_S_Wp_Lh_V_Tf_Ysor7p_Rg_U_Ut_ANWND_6ye2_Ros_a0f7f177f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

