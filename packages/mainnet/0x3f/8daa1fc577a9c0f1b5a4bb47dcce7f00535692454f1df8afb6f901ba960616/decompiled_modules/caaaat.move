module 0x3f8daa1fc577a9c0f1b5a4bb47dcce7f00535692454f1df8afb6f901ba960616::caaaat {
    struct CAAAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAAAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAAAAT>(arg0, 6, b"CAAAAT", b"AAAA CAT", b"AAAAAAAAAAAAAAAAAAA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XPA_1_C5_B_Vc_MB_Av_LK_9mraa_U6_UC_95_X6w_Fy_Cw_MF_Cb_Mxy_Xh_GD_e66edc866e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAAAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAAAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

