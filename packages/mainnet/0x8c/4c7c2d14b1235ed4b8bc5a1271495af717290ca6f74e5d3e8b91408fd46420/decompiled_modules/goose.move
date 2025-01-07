module 0x8c4c7c2d14b1235ed4b8bc5a1271495af717290ca6f74e5d3e8b91408fd46420::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"GOOSE", b"GOOSE OR DUCK", x"49276d206261636b2120546869732074696d6520492077696c6c20636f756e74657261747461636b20616e64206265636f6d65206120676f6f73652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Xg_Umtf_Vqee_Dpy_Y3_DP_7fn_XV_Xbz_C4wb_C4_Jo_B_Su_WB_2_Ccz3_ce9ddae96e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

