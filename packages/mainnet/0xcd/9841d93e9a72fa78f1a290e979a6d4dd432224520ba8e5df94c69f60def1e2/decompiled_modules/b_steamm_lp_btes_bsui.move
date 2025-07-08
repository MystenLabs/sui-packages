module 0xcd9841d93e9a72fa78f1a290e979a6d4dd432224520ba8e5df94c69f60def1e2::b_steamm_lp_btes_bsui {
    struct B_STEAMM_LP_BTES_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BTES_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BTES_BSUI>(arg0, 9, b"bSTEAMM LP bTES-bSUI", b"bToken STEAMM LP bTES-bSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BTES_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BTES_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

