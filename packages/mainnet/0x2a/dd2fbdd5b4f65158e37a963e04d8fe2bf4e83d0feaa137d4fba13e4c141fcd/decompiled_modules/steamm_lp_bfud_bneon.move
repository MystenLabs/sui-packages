module 0x2add2fbdd5b4f65158e37a963e04d8fe2bf4e83d0feaa137d4fba13e4c141fcd::steamm_lp_bfud_bneon {
    struct STEAMM_LP_BFUD_BNEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BFUD_BNEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BFUD_BNEON>(arg0, 9, b"STEAMM LP bFUD-bNEON", b"STEAMM LP Token bFUD-bNEON", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BFUD_BNEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BFUD_BNEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

