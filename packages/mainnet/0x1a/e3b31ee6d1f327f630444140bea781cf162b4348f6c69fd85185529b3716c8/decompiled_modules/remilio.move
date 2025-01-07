module 0x1ae3b31ee6d1f327f630444140bea781cf162b4348f6c69fd85185529b3716c8::remilio {
    struct REMILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIO>(arg0, 6, b"Remilio", b"Remilios", b"This is the first Remilio on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yk5_M_Le_HM_91_Lg_SEQVULH_Sqi_Va_QJ_Jc3p_FM_Tjnd1j68_DCPJ_7d41723e56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

