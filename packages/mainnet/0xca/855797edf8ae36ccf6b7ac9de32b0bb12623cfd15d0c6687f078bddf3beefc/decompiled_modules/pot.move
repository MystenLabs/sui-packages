module 0xca855797edf8ae36ccf6b7ac9de32b0bb12623cfd15d0c6687f078bddf3beefc::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"POT", b"SUI POT", b"$POT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_F9ynft_RH_Yq3_Und_Tqp_Tr7h_PU_Ugpyn_C_Piq_Hx_Jisq_Gt_Xj_H_3c1b29b153.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

