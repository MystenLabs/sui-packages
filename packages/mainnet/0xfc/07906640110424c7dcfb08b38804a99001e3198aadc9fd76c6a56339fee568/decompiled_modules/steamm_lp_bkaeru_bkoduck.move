module 0xfc07906640110424c7dcfb08b38804a99001e3198aadc9fd76c6a56339fee568::steamm_lp_bkaeru_bkoduck {
    struct STEAMM_LP_BKAERU_BKODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKAERU_BKODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKAERU_BKODUCK>(arg0, 9, b"STEAMM LP bKaeru-bKoduck", b"STEAMM LP Token bKaeru-bKoduck", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKAERU_BKODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKAERU_BKODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

