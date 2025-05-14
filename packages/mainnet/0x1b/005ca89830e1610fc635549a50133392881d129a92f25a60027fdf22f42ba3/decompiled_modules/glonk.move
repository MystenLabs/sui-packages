module 0x1b005ca89830e1610fc635549a50133392881d129a92f25a60027fdf22f42ba3::glonk {
    struct GLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLONK>(arg0, 6, b"GLONK", b"Glonk", b"Does absolutely nothing and dies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zix5iwc7fjv_Chp_WJ_Kdei_FRW_Fo_ML_Wj_HK_Ah_A_Wb_Yg_JEGS_Me_4e8f928184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

