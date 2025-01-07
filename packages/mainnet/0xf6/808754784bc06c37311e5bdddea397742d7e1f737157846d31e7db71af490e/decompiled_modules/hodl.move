module 0xf6808754784bc06c37311e5bdddea397742d7e1f737157846d31e7db71af490e::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"Hiding Outside During Light", b"Cat is hiding outside during the bright light of the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbh46oa9_Qn_A_Xdf_Hzf9x_LG_Yq2_T_Pyic_T_Tm_Df5_Hekb_Nn_Woe_B_e2dc13c857.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

