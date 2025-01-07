module 0x4144f10835a75381cded212d8e1091d90542588c0e748426dd36d3c4dfb578::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Bone Game", x"24424f4e4520616e20756e69717565206f6e20636861696e206578706572696d656e74200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd9k_Udx_T_Jag_Za8_G47a_Six9_KRC_9_Yj_Wjozv29f_J_Da_Xj8s_B7_6fc9c266e9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

