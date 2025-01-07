module 0x287cbefa8427b0c52f0eef920877cefc90b09067d968a781ac1fe963c9a11ffa::shitpeng {
    struct SHITPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITPENG>(arg0, 6, b"ShitPeng", b"Shitting Penguin", x"4a75737420796f75722061766572616765207368697474696e672050656e6775696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Bj_H_Dfrpt_EZ_Pbbwt_Tw_Pi65vr_Fg_Vs7s3o_C_Zwhap8y7_Jh_S_b4283b75d9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

