module 0xb272ac43bca390dcc185048b49706e8b49a86cbf63c25f54ebaa58815976cbd0::steamm_lp_blars_bdeep {
    struct STEAMM_LP_BLARS_BDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLARS_BDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLARS_BDEEP>(arg0, 9, b"STEAMM LP bLARS-bDEEP", b"STEAMM LP Token bLARS-bDEEP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLARS_BDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLARS_BDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

