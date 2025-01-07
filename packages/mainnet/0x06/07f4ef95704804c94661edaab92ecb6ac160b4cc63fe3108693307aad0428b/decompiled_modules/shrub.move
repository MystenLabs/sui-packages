module 0x607f4ef95704804c94661edaab92ecb6ac160b4cc63fe3108693307aad0428b::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUB>(arg0, 6, b"SHRUB", b"Elon Hedgehog", b"https://x.com/elonmusk/status/1852932247881494753", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pey7_BPD_Un3n_D1_XN_Jdaep_P_Ey_CJH_1jw_Lco_Gs_Xo14_Wo_R_Abd_5983a0f7db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

