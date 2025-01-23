module 0x4a62f2d393401c7249ffc8745ecaa693920e9ea0956a8968c2a5976efa0018b6::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"troll emoji", b"When I see the troll emoji , its like looking in the mirror", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_H3b_MGFU_6ew7_TV_3_Jtv8_Peh_X_Nj_HX_Hy9_YM_6_Cx_KUZ_Fyas_NP_c1a393f8aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

