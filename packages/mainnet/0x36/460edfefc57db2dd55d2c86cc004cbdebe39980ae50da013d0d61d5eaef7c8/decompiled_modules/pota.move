module 0x36460edfefc57db2dd55d2c86cc004cbdebe39980ae50da013d0d61d5eaef7c8::pota {
    struct POTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTA>(arg0, 6, b"POTA", b"Potato Dad Disorder", x"4c6574732063656c65627261746520616c6c2074686520706f7461746f2066617468657273206f75742074686572652e205468616e6b20796f7520666f72206675636b20616c6c2c20616c6c207965617220726f756e640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y4_D_Wh_N_Tr_HYCG_Pw2mx6_ZDEM_1_UTC_4_A1_VC_3p_Gk_X5_H1ae_C6_V_e3818ecdb1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

