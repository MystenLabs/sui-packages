module 0xe06fa959e720893a8699604a69d22c26e2dee3fba898325ad0cf99847a4c5b2::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"Side Eye Dog", x"436f636f2c20616c736f206b6e6f776e206173207468652027736964652065796520646f6727206973206f6e65206f6620746865206d6f737420766972616c20646f67206d656d6573206f6e2074686520696e7465726e65742e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Up_WNW_7vk_Zsz_K_Ry_Pk_Sbrr2_XKJ_4_Ro_GW_5o74_Rt5_S3_ZJ_2_Mj_P_2eb85fc6e3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

