module 0xbb461aeeb873b58d781b6e062a7ce04506fff376f8a770b42abf8e5af65ba5e7::steamm_lp_bskn_undefined {
    struct STEAMM_LP_BSKN_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSKN_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSKN_UNDEFINED>(arg0, 9, b"STEAMM LP bSKN-undefined", b"STEAMM LP Token bSKN-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSKN_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSKN_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

