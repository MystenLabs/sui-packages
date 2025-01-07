module 0x693c23413761df6fb57237eca70f66bad00326e28b105ebdcae82d0636549d0a::z3ro {
    struct Z3RO has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z3RO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z3RO>(arg0, 6, b"Z3RO", b"Z3RO AI CAT", b"01101000 01101001 01100111 01101000 01100101 01110010", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qt_RA_5_Zo_QHXN_Eit_Um_H97_F_Ppf_Q_Ppp_Lv_ZH_1_T5_Ud_Foz5pcnu_a605e0fe90.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z3RO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Z3RO>>(v1);
    }

    // decompiled from Move bytecode v6
}

