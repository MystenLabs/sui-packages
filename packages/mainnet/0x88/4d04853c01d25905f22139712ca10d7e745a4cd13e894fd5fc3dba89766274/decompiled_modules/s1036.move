module 0x884d04853c01d25905f22139712ca10d7e745a4cd13e894fd5fc3dba89766274::s1036 {
    struct S1036 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S1036, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S1036>(arg0, 6, b"S1036", b"SUI 1036", x"313033362068617320666f726d65642061207361666520686176656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qfvw_YM_As5cnfife_EC_7_C5_Bpuv_E_Eqffdt_Mufc_Fa_Mh5b_Xk_E_5e4362adbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S1036>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S1036>>(v1);
    }

    // decompiled from Move bytecode v6
}

