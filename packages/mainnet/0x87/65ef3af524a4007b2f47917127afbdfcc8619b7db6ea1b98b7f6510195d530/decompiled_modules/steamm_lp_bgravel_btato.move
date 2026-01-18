module 0x8765ef3af524a4007b2f47917127afbdfcc8619b7db6ea1b98b7f6510195d530::steamm_lp_bgravel_btato {
    struct STEAMM_LP_BGRAVEL_BTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BGRAVEL_BTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BGRAVEL_BTATO>(arg0, 9, b"STEAMM LP bGRAVEL-bTATO", b"STEAMM LP Token bGRAVEL-bTATO", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BGRAVEL_BTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BGRAVEL_BTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

