module 0x267f4bf29a07ff55f6c7de8edab655e6474e7512d4b12944df5f09e3da4b2409::skelly {
    struct SKELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELLY>(arg0, 6, b"SKELLY", b"Skelly", b"hashgrave AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RK_Xjr_DD_Nb_Ys3c9_U_Gu_Rnid8d_Uf_Kywu_Y4_Sbhhqo_V_Cn_Uzk_L_6b571f4260.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

