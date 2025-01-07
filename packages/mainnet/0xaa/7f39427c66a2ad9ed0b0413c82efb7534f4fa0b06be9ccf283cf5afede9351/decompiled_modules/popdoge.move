module 0xaa7f39427c66a2ad9ed0b0413c82efb7534f4fa0b06be9ccf283cf5afede9351::popdoge {
    struct POPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOGE>(arg0, 6, b"POPDOGE", b"PopDoge", b"The one and only Popdoge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VB_3nsjm_Nm5_DSN_7h_M_Ljfiut_E_Gk_Z_Uxt_TU_Hh_Jq_NSRRV_Ly74_c5c8db48b7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

