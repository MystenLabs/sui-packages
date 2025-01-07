module 0xa843ac3f08386f3591154cba34ecf1212ba9abf757eb6234730051c686a23928::dadadaa {
    struct DADADAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADADAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADADAA>(arg0, 6, b"Dadadaa", b"Ddadfa", b"adada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000_F_571182303_r_Cv_E3owc_Bf_Qn_I6o_Cya_Fj_TU_3s_Hu_A7_HK_52_20d4f06e9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADADAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADADAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

