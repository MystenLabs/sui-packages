module 0x796b51b43446730c2ef71a62d13062aa80a2b257d2e223189dde5513105d3db5::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"MARIE", b"Marie", x"4d6172696520526f73650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yr_UGR_1em6_Ux_Q_Yz_YS_Gr_Gh_Rktau7_J2_V24_CGBXZ_Bgz53_VP_5_00f33c77ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

