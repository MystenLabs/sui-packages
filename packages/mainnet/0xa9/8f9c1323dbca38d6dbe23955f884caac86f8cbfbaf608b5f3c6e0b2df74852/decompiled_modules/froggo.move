module 0xa98f9c1323dbca38d6dbe23955f884caac86f8cbfbaf608b5f3c6e0b2df74852::froggo {
    struct FROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGO>(arg0, 6, b"FROGGO", b"FrogGo", b"Dev is just a froggo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_K64u_ZY_Wu7th_Sn_Ts_Ht_Db_Pv_Qg65ch_Bgn_EXHA_1v_LSHK_Ph_K_e52f39e35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

