module 0x8beb3a39263abdb8aaae5084a67f304fd4c0a50503e480c30cdd6b6dccaf04eb::steamm_lp_bzup_undefined {
    struct STEAMM_LP_BZUP_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BZUP_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BZUP_UNDEFINED>(arg0, 9, b"STEAMM LP bZUP-undefined", b"STEAMM LP Token bZUP-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BZUP_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BZUP_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

