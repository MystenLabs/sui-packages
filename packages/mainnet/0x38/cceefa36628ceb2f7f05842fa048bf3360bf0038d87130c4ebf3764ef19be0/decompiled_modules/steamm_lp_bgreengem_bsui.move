module 0x38cceefa36628ceb2f7f05842fa048bf3360bf0038d87130c4ebf3764ef19be0::steamm_lp_bgreengem_bsui {
    struct STEAMM_LP_BGREENGEM_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BGREENGEM_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BGREENGEM_BSUI>(arg0, 9, b"STEAMM LP bGREENGEM-bSUI", b"STEAMM LP Token bGREENGEM-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BGREENGEM_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BGREENGEM_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

