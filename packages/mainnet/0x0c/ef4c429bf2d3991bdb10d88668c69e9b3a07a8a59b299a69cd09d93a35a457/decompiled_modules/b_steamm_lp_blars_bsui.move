module 0xcef4c429bf2d3991bdb10d88668c69e9b3a07a8a59b299a69cd09d93a35a457::b_steamm_lp_blars_bsui {
    struct B_STEAMM_LP_BLARS_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BLARS_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BLARS_BSUI>(arg0, 9, b"bSTEAMM LP bLARS-bSUI", b"bToken STEAMM LP bLARS-bSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BLARS_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BLARS_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

