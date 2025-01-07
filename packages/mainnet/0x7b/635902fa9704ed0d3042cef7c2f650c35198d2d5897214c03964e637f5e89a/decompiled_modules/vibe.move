module 0x7b635902fa9704ed0d3042cef7c2f650c35198d2d5897214c03964e637f5e89a::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBE>(arg0, 6, b"VIBE", b"Vibe Dog", x"43616e27742073746f7020766962696e672c20776f6e27742073746f7020766962696e672e20556c74696d61746520766962696e6720646f672e20466f726576657220766962657320696e20796f75722077616c6c65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Zq_VUB_7on_Zq_U1_F7ndsm_VLP_2kbb_Lu_Ku_Kw_XR_5rf_Kt_BV_Ba_S_9f2cdb44eb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

