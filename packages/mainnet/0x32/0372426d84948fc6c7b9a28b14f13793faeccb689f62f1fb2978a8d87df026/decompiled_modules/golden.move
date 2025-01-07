module 0x320372426d84948fc6c7b9a28b14f13793faeccb689f62f1fb2978a8d87df026::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN>(arg0, 6, b"Golden", b"GoldenMagaHat", b"Golden Maga Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Ewxdos_Q_Mtn_Vu1_Nf_N4r_U_Jzm_PDB_Ahgp_X9ip78_N_Gs8gvp7_c933e1f016.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

