module 0xff7a7ac13fc58e1c2e642d8de296ead5e18458d61e1071fccd01bea500e29b5::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 6, b"FU", b"Farting Unicorn By Elon Musk", b"Farting Unicorn By Elon Musk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XG_Gj_NZ_Tj_D7_Sjt2_DU_Sc_VX_8_Nv_Zn_UBG_Ps9ib8wa_Gnbhos_Yh_c6fd1d28a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FU>>(v1);
    }

    // decompiled from Move bytecode v6
}

