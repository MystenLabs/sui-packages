module 0xa13b04847b3d406ddc8a679e9daad335da5f488aa9167d01d95ca1dd011be0f7::blobot {
    struct BLOBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBOT>(arg0, 6, b"BLOBOT", b"Blobo Trump", x"22426c6f626f222072656665727320746f20616e206578706c6f697461626c65204d53205061696e7420696d616765206f66206120626c6f6266697368206672657175656e746c7920706f73746564206f6e20346368616e20616e64206f7468657220666f72756d732077697468207468652073656e74656e63652c2022424c4f424f54204953204e4557204d454d45220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z3vb5hb_Scm_DP_Jeq6d6_Dpg7_Xac_LT_96_DMC_Sk_Xf9_TA_3_Jks_S_c0a4aa7ad6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

