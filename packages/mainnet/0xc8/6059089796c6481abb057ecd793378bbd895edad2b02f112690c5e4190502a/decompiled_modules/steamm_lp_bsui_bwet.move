module 0xc86059089796c6481abb057ecd793378bbd895edad2b02f112690c5e4190502a::steamm_lp_bsui_bwet {
    struct STEAMM_LP_BSUI_BWET has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BWET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BWET>(arg0, 9, b"STEAMM LP bSUI-bWET", b"STEAMM LP Token bSUI-bWET", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BWET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BWET>>(v1);
    }

    // decompiled from Move bytecode v6
}

