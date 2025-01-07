module 0x21bddd40b07df2a7672062e98444f29ffddf1a26b56c17ffb0ba2702f735ccc8::wmd {
    struct WMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMD>(arg0, 6, b"WMD", b"Whale's Massive Dick", b"The whale is Massive Dick and is a massive dick $WMD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Uivi9_Csh_YX_Ga_V2h_S_Foc_Cmgz_Cj_T5o_Ri_Vrqc6_U_Bdjh_Tqi_5121417119.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

