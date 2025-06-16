module 0x82b378f52f5da4e2854b8eea27671f2bd51c1c29ef9c4774cdaf372d579bc8df::steamm_lp_bnot_bwal {
    struct STEAMM_LP_BNOT_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BNOT_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BNOT_BWAL>(arg0, 9, b"STEAMM LP bNOT-bWAL", b"STEAMM LP Token bNOT-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BNOT_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BNOT_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

