module 0x3727838e1791008757f1edd32296687cf16e73f0cc8d1b3f36e20f8df87a804a::monki {
    struct MONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKI>(arg0, 6, b"MONKI", b"Monki", x"697427732061206d6f6e6b692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pz_NA_Rsofqiv_FKU_5n2_P9h_H_Cv_H_Mt8_C_Zwh_MM_6d_XJCKLE_Kps_8c5d7b724e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

