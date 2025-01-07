module 0xc338c49d5b199e235afd9af4e6d33d9e5b3e033fa43c392cbe86dfcee3f2f102::sj {
    struct SJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJ>(arg0, 6, b"SJ", b"SOLJERK", b"HELLO, I AM SOLJERK MID 30 YEARS OLD PORN ADDICTED AND HOMELESS. I HAVE NO FRIENDS LOST MY ID AND NO COIN TO SHARE WITH OTHERS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc19qa_SA_Yiv_W_Wbj_Em_FY_Cb_Rm_F8b_K_Le4_XZJQ_1dx6_ZK_7f_Ney_5c6184b796.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

