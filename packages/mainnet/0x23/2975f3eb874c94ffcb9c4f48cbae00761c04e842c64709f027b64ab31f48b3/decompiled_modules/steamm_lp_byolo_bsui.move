module 0x232975f3eb874c94ffcb9c4f48cbae00761c04e842c64709f027b64ab31f48b3::steamm_lp_byolo_bsui {
    struct STEAMM_LP_BYOLO_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BYOLO_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BYOLO_BSUI>(arg0, 9, b"STEAMM LP bYOLO-bSUI", b"STEAMM LP Token bYOLO-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BYOLO_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BYOLO_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

