module 0x9120801ca09d0285caeca33c705844d8407f7284d1d29d9de7510390642c1f80::steamm_lp_bkfc_bblub {
    struct STEAMM_LP_BKFC_BBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKFC_BBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKFC_BBLUB>(arg0, 9, b"STEAMM LP bKFC-bBLUB", b"STEAMM LP Token bKFC-bBLUB", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKFC_BBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKFC_BBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

