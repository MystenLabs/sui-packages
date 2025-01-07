module 0xd3ca5bcf1186a94554023250d43b2fd402f3198bd7eb3a74642d2e9ac47c0a54::gaynance {
    struct GAYNANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYNANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYNANCE>(arg0, 6, b"GAYNANCE", b"GAYNANCE SUI", b"GAYNANCE SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bg_MXYV_Bf_QZ_Xc_Rh_DL_Moh_Kq_De3_Fpvk_Zh_VB_Umdxnij_A_Ypz_P_a435dd4ab7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYNANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYNANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

