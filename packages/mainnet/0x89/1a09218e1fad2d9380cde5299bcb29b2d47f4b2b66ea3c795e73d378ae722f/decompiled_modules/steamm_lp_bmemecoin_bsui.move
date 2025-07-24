module 0x891a09218e1fad2d9380cde5299bcb29b2d47f4b2b66ea3c795e73d378ae722f::steamm_lp_bmemecoin_bsui {
    struct STEAMM_LP_BMEMECOIN_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMEMECOIN_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMEMECOIN_BSUI>(arg0, 9, b"STEAMM LP bMEMECOIN-bSUI", b"STEAMM LP Token bMEMECOIN-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMEMECOIN_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMEMECOIN_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

