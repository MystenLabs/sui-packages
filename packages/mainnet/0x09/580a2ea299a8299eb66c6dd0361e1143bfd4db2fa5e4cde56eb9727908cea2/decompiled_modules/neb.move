module 0x9580a2ea299a8299eb66c6dd0361e1143bfd4db2fa5e4cde56eb9727908cea2::neb {
    struct NEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEB>(arg0, 6, b"NEB", b"Nebula", x"4120446966666572656e742047616c6178790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Uwm_Ad7_R_Mx_L_Km5_T_Hvf6_SJC_Rj_R_Urm9kw_Efzr_RJ_6_Ck_Dxkn_8b26836c1a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

