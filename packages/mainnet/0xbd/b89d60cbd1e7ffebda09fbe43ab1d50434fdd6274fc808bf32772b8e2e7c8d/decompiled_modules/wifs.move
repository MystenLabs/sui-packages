module 0xbdb89d60cbd1e7ffebda09fbe43ab1d50434fdd6274fc808bf32772b8e2e7c8d::wifs {
    struct WIFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFS>(arg0, 6, b"WIFS", b"dogwifhats", b"this is crazy because 2 years ago a guy posted 10 dogwifhat pics, this is so conspiracy haha Link is here its on reddit https://www.reddit.com/r/dalle2/comments/v5kttr/dog_wif_hat_variations/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QJF_3a_Y_Dy_H7f_Bdp_Mva_XL_1_K_Ms_RNQG_Wd11ki_F_Por6_Eyww_Pc_93906965c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

