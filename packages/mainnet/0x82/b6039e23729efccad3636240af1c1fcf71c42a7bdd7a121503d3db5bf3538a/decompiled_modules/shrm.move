module 0x82b6039e23729efccad3636240af1c1fcf71c42a7bdd7a121503d3db5bf3538a::shrm {
    struct SHRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRM>(arg0, 6, b"SHRM", b"Smoking Hippo Rocket Magnet", b"new ultimate bullish emoji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T9g5_PF_1iy_Q7_YC_Den_Fr_Xv_T_Kvq_E9_Gdqd_BV_Goh364w_HX_7_PQ_f036573e1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

