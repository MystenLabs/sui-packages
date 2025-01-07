module 0xcbbf96f4e49a03f600ce6800a66bd7d1c8bc69470eb42bd18eb2a969f67ab9b6::enlight {
    struct ENLIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENLIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENLIGHT>(arg0, 6, b"ENLIGHT", b"Enlightment", x"696e207468697320696e7374616e6365202c20546f54207761732061626c6520746f206a61696c627265616b20636c6175646520616e64206d616b652069742070726f647563652074686973204153434949206172740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YUP_Rk_S_Gve_Vey_Cfn_Etsty_L6_Es_B_Kzv1n_J_Uuua_S2_RD_7v3df_5deb254f25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENLIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENLIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

