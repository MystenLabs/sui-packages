module 0x5429c36f2eecf847a27223a9675d77200ee46cc1101b6d66fa9f479b4a438630::steamm_lp_bkam_bsui {
    struct STEAMM_LP_BKAM_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKAM_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKAM_BSUI>(arg0, 9, b"STEAMM LP bKAM-bSUI", b"STEAMM LP Token bKAM-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKAM_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKAM_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

