module 0x55bf008d50e9697dad942d01fe47dc0281b86e07c95a894e23381469963f5718::lumi {
    struct LUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMI>(arg0, 6, b"LUMI", b"Lumi Sui", b"YOLO, FOMO, $LUMI. The real OG bear of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H_Bbx39_XQ_Fq_Qf3_Qg_Z_Lb1rt_Mfox_JB_Sq_YR_Dg_Kxz_T_Mq_Wpump_d0e760453e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

