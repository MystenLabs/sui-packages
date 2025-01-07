module 0xde7fd5c42592d0d081a5f51eb3337c34372ed222d1f84f6aaeb44f953f9b67d3::ganggang {
    struct GANGGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGGANG>(arg0, 6, b"GANGGANG", b"Gang Gang", b"GANGGANG: The Ultimate Meme Squad is Here! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_RP_5gm_Ts7_Wk_Rd_Wn_QSS_Xys_EKF_8gj_EGP_Mvp231em_Q_Qeg_R3_91d45de675.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

