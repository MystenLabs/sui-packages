module 0x8d0eb5bb054ac2af1261c322f0098b28d040812d16f86f14340a2ddb7e6299d2::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"ROCKY", b"ROCKY SUI", x"526f636b76696c6c657320746f70206a6f6b657374657220616e64206d656d65206c6567656e642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R6n_K9q_Ncj4z_VJ_Ay_Na_F_Zs98_EMSXJ_Pe_S7_Bcbj_Qxwxi_Gb_ZA_84d6e1beab_0c43da8350.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

