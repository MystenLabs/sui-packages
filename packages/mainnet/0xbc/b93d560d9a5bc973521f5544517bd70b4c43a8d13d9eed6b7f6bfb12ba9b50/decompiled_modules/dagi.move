module 0xbcb93d560d9a5bc973521f5544517bd70b4c43a8d13d9eed6b7f6bfb12ba9b50::dagi {
    struct DAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGI>(arg0, 6, b"DAGI", b"Dark AGI Arena", x"20414749204172656e61207c20576865726520696e6e6f766174696f6e206d6565747320696e74656c6c6967656e636520207c204578706c6f72696e67207468652066726f6e74696572206f66204172746966696369616c2047656e6572616c20496e74656c6c6967656e6365207c2049646561732c20696e7369676874732c20616e6420627265616b7468726f75676873210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_A3_Ma_G_Qwret_Yx_X6_N_Qn_SQ_Wqj_YMT_Rhtw357x_Vvbiv_QH_Vd1_5d34192b42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

