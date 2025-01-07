module 0x190172389c08a949755c03ab6cc9e75073c146c734e8be945a59fad5f53b38af::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"Memecoin Supercycle", b"Memecoin Murad  -https://x.com/MustStopMurad/status/1846182072093684061 -https://x.com/MustStopMurad/status/1845963293250179445 -https://x.com/MustStopMurad/status/1845878204244152445  -https://x.com/MustStopMurad/status/1845476489157853667 -https://x.com/MustStopMurad/status/1845255235964416499 -https://x.com/MustStopMurad/status/1845172214397882822 -https://x.com/MustStopMurad/status/1845105397662646470 ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28_Xc1_NL_8xmlwxj_Gw_RLG_6_GY_8_Q_f_K45k94_Qp_Cq_Xr_JR_1_A_ae7251e038.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

