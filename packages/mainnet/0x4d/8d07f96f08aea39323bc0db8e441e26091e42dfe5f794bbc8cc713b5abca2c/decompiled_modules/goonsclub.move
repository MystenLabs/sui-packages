module 0x4d8d07f96f08aea39323bc0db8e441e26091e42dfe5f794bbc8cc713b5abca2c::goonsclub {
    struct GOONSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOONSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOONSCLUB>(arg0, 6, b"GOONSCLUB", b"Gold Skelly Edition", b"The next generation of figurines, plushies, and digital collectibles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Pi_Giu6t_EE_Fz_Kx_P_Jtc_AD_Us_Dd9_KU_685_QG_Ztoz3_Lk_YX_26_D_20a3aa8857.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOONSCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOONSCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

