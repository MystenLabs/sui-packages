module 0xece263544e277bd073c32556b1936219aa5b11edb4f8ff3963d2caa489fc5ee4::shibp {
    struct SHIBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBP>(arg0, 6, b"SHIBP", b"Shiba President", x"536869626120507265736964656e742069732061206772656174206c65616465722077686f2077696c6c206368616e6765206e6f74206f6e6c792074686520636f756e747279206275742074686520776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xe_Ao_RCD_Bzdb72_Pv_UR_Edpb_MG_Urd_AW_Dwh2_MJ_Tt_Z6f3h_Dz_E_02dab8d5d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

