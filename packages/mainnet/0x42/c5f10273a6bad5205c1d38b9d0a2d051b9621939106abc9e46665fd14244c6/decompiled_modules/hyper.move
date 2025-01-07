module 0x42c5f10273a6bad5205c1d38b9d0a2d051b9621939106abc9e46665fd14244c6::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 6, b"HYPER", b"Hyperutility", b"Bridge bot and more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R6_P4nsn_Kfw_Jamn_S82_T_Eiae_LN_Fo_T_Piq2_D_Wq_Nkz_Nh_Nkj_Xh_b377124095.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

