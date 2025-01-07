module 0x81953050c12d54c090470b0700da736d38b0f196901b73191a9525757604a18b::difyai {
    struct DIFYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIFYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIFYAI>(arg0, 6, b"DifyAI", b"Dify Ai", x"4469667920697320616e206f70656e2d736f75726365204c4c4d2061707020646576656c6f706d656e7420706c6174666f726d2e204f72636865737472617465204c4c4d20617070732066726f6d206167656e747320746f20636f6d706c657820414920776f726b666c6f77732c207769746820616e2052414720656e67696e652e0a0a4d6f72652070726f64756374696f6e2d7265616479207468616e204c616e67436861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_9_YC_Wlz_400x400_1cb421c6b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIFYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIFYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

