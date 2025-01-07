module 0xd445b6c31bb1a95213638f5a2501594102772498c8ad2a2008e6e3b0e338b391::woang {
    struct WOANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOANG>(arg0, 6, b"WOANG", b"WOANG WOANG", b"WOANG ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sravzg_Y_Xe5y_B_Pu_Nx_Xvs_Ljv_Rbx_VYD_1_W86rr_ZCK_Ti1wk_QL_f1ab6b102f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

