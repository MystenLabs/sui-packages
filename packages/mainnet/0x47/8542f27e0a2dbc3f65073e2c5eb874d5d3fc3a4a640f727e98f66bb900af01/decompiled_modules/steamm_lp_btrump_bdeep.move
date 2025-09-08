module 0x478542f27e0a2dbc3f65073e2c5eb874d5d3fc3a4a640f727e98f66bb900af01::steamm_lp_btrump_bdeep {
    struct STEAMM_LP_BTRUMP_BDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTRUMP_BDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTRUMP_BDEEP>(arg0, 9, b"STEAMM LP bTRUMP-bDEEP", b"STEAMM LP Token bTRUMP-bDEEP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTRUMP_BDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTRUMP_BDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

