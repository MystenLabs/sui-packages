module 0x370caa01a236a2d4c2ab436ecf666762006055c1fd73f52459e30c9d42d38e16::plm {
    struct PLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLM>(arg0, 6, b"PLM", b"Porn Language Model", x"506f726e204c616e6775616765204d6f64656c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaj_Q9w_Uy_X7_ZST_2i_Z8f_Vk75_U_Mis_Wbb_K_Tkjd_Z3_Ymyf1_Vt_UQ_c253563f80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

