module 0x83c703c54574399ef3388e9bf9c2ceb940210e59e5b6cd9d1544cc5c3b5b1895::fwogie {
    struct FWOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGIE>(arg0, 6, b"FWOGIE", b"FWOG", x"496e20746865206173686573206120636f6d6d756e69747920656d65726765642c2061206e657720666c6f672c2061206d6f726520626173656420666c6f672c20612046574f472046574f4720686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q4_H6_Y23d_S_Ejn9_LKB_85_M7_Kp_V_Fi_Du6_Kf_DNZ_Acrqi_Cw_FQQH_68d40e2869.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

