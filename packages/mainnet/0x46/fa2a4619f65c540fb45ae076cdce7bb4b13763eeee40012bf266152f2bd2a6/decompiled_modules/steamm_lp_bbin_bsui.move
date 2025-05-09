module 0x46fa2a4619f65c540fb45ae076cdce7bb4b13763eeee40012bf266152f2bd2a6::steamm_lp_bbin_bsui {
    struct STEAMM_LP_BBIN_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBIN_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBIN_BSUI>(arg0, 9, b"STEAMM LP bBIN-bSUI", b"STEAMM LP Token bBIN-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBIN_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBIN_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

