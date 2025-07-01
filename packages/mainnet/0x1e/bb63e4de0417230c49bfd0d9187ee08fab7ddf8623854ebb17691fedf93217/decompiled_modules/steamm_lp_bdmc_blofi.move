module 0x1ebb63e4de0417230c49bfd0d9187ee08fab7ddf8623854ebb17691fedf93217::steamm_lp_bdmc_blofi {
    struct STEAMM_LP_BDMC_BLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BDMC_BLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BDMC_BLOFI>(arg0, 9, b"STEAMM LP bDMC-bLOFI", b"STEAMM LP Token bDMC-bLOFI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BDMC_BLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BDMC_BLOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

