module 0xab87fd453ccd474e5a398d612081aa0bb7865d4875b350369a32a6a48f1cec33::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORM>(arg0, 6, b"WORM", b"Deep Worm", x"496d6d6f7274616c206469676974616c206c69666520696e2074686520666f726d206f66206120576f726d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_RL_Zp3_Hbs_K6q4cw_T_Bo8_Hi_Sqk8_Bq_Wpmy_Trhf_ZB_Rteizc_Z_30a9da6913.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

