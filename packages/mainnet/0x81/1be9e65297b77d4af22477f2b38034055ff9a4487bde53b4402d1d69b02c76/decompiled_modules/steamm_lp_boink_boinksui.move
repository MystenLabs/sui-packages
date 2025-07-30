module 0x811be9e65297b77d4af22477f2b38034055ff9a4487bde53b4402d1d69b02c76::steamm_lp_boink_boinksui {
    struct STEAMM_LP_BOINK_BOINKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOINK_BOINKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOINK_BOINKSUI>(arg0, 9, b"STEAMM LP bOINK-boinkSUI", b"STEAMM LP Token bOINK-boinkSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOINK_BOINKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOINK_BOINKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

