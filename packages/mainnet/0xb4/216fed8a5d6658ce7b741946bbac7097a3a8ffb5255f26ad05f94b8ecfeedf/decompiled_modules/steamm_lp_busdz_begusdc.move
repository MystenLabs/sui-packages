module 0xb4216fed8a5d6658ce7b741946bbac7097a3a8ffb5255f26ad05f94b8ecfeedf::steamm_lp_busdz_begusdc {
    struct STEAMM_LP_BUSDZ_BEGUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDZ_BEGUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDZ_BEGUSDC>(arg0, 9, b"STEAMM LP bUSDZ-begUSDC", b"STEAMM LP Token bUSDZ-begUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDZ_BEGUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDZ_BEGUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

