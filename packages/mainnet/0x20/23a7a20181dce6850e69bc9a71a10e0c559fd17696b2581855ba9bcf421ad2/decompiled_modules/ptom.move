module 0x2023a7a20181dce6850e69bc9a71a10e0c559fd17696b2581855ba9bcf421ad2::ptom {
    struct PTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOM>(arg0, 6, b"PTOM", b"PHWANTOM", x"6a757374206120706877616e746f6d20696e206120737472616e676520776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xs_Wh_JMED_8dtwfk_X2x_JB_1_Vynx_Fsm_Xnsf7x_W_Dk9h9_K8p_GA_929437a519.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

