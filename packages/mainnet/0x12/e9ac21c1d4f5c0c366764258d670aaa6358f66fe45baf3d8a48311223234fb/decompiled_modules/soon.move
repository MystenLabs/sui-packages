module 0x12e9ac21c1d4f5c0c366764258d670aaa6358f66fe45baf3d8a48311223234fb::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 6, b"Soon", b"Mr.Soon", b"A cult community of retail crypto traders fed up with endless empty promises from crypto founders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zn_Q4ts_L8h_P_Duta5a_H2_L_Pt_QMA_6_XW_Rov_Xg_Qkno_CB_5w_J8_Wt_cc3c07008e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

