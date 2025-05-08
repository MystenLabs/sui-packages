module 0xe9dbc5ba324133a2c0bd870bceb7048cdf35a441e64ac7ea0edd501874d6416e::steamm_lp_bmco_undefined {
    struct STEAMM_LP_BMCO_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMCO_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMCO_UNDEFINED>(arg0, 9, b"STEAMM LP bMCO-undefined", b"STEAMM LP Token bMCO-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMCO_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMCO_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

