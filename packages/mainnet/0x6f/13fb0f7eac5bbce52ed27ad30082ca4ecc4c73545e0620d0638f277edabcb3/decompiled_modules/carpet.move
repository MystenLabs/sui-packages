module 0x6f13fb0f7eac5bbce52ed27ad30082ca4ecc4c73545e0620d0638f277edabcb3::carpet {
    struct CARPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARPET>(arg0, 6, b"CARPET", b"Carpet", x"24434152504554202d204e6f742061207275672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZB_Nb_Skiv_Ey_Vxy_Zivy_Moy_Yqh_Su_Kt8go_Etv_Wmc5m_Dihehc_322116be52.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

