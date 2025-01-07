module 0xfe135398e60a62f39117c8f5ff90dd1888e66641d6b8fd8f5e2e31cfa5e0eb3f::maymo {
    struct MAYMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYMO>(arg0, 6, b"MAYMO", b"Maymo the lemon beagle", b"Maymo is a seriously funny lemon beagle dog made famous by his extremely cute and derpy activities. His videos have appeared on major television shows and websites.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zxyf1q_M_Sfsz8_Zt_ERS_1pqj_V_Cd84_P_Dzg_Akg_LG_5i_Nv_R9_YLD_2a1659a760.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAYMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

