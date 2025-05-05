module 0xea207312d74c1fba489b2134efaf4fb8c3099f1b156e2889d497e28d5642ed9b::steamm_lp_bsuieth_undefined {
    struct STEAMM_LP_BSUIETH_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUIETH_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUIETH_UNDEFINED>(arg0, 9, b"STEAMM LP bsuiETH-undefined", b"STEAMM LP Token bsuiETH-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUIETH_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUIETH_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

