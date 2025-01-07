module 0x4403c59c17646ce94bc19676ad8daf85be2277a9d304b22370141835336d71f::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"SUICATFISH", b"NEVER EVER FALL IN LOVE WITH A MEMECOIN, UNLESS ITS NAME IS $CATFISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ac_Y6_R_Wu_WKM_5_NU_7_Be_SE_4c4z_Qx_B_Zpy_U7p_TLNF_3g5_DTWUC_2_c3190972d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

