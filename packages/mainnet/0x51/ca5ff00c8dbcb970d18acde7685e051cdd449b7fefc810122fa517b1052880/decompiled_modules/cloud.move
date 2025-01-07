module 0x51ca5ff00c8dbcb970d18acde7685e051cdd449b7fefc810122fa517b1052880::cloud {
    struct CLOUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUD>(arg0, 6, b"CLOUD", b"SUICLOUD", b"Liquid Staking, Reimagined. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Lo_UD_Kc4_Ane7_He_Qc_Pp_E3_Y_Hnzn_Rxh_Mim_J4_Mya_Uqy_H_Fz_Au_6e12219d3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

