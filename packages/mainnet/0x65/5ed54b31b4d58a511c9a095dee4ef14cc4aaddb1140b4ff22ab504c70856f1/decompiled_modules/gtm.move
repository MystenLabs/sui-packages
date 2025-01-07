module 0x655ed54b31b4d58a511c9a095dee4ef14cc4aaddb1140b4ff22ab504c70856f1::gtm {
    struct GTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTM>(arg0, 6, b"GTM", b"Going To Moon", x"4172652075207265616479203f2057652061726520676f696e6720746f206d6f6f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Vm_D3mrv_SU_Qn_Jn_Zrr3z_GVU_Cs8_Fj9_Jd_K73_M_Tr_BYV_4_Aq_QP_0eb0f8fe6c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

