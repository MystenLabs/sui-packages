module 0xbe1a76047cd2759ec57a62ef5e577ff1b12b7245e705bd77487db2aa45f4f705::k {
    struct K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K>(arg0, 6, b"K", b"K I Aped", b"ticker: K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Jv_T_Br_Tc36_Vhof6t9_BN_8_Dvu4p_L_Xncm_Mm_Rcij9_Zp1o_DQ_4_ba086a1d24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<K>>(v1);
    }

    // decompiled from Move bytecode v6
}

