module 0x4c939c2aeda14bf0357ddf62763c15524c7c8e72c2a904fddfaa2fc9b9d4da3f::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"Satoshi", b"J.A.Donald - Satoshi Nakamoto's Real Name", b"Satoshi Nakamoto's Real Name - J. A. Donald", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Aeo_Mgg_Y_Ppz9qfh_Zzv122bf_Gr_Cicu_CT_Kj_G_Uq5_MQL_6_Eg_H_7ffde2efb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

