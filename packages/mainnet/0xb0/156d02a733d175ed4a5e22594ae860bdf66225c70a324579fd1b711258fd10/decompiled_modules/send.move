module 0xb0156d02a733d175ed4a5e22594ae860bdf66225c70a324579fd1b711258fd10::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 6, b"SEND", b"Sendooor", x"50756d7020746869732070756d7020746861742e20486f772061626f75742073656e646f6f723f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V9_A_Vv_He_UJ_Fq_Bn8z3_B_Viwi_Pi7_VKPD_3_NDW_2bc6_Bj_V_Mc_MLS_4eb812bda9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

