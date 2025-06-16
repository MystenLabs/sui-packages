module 0xf4267eacb22b0cc3a93efc3a74a7deb1a565b4d948a4ca3326d63b3fc67c6f3f::steamm_lp_bsuki_bkoduck {
    struct STEAMM_LP_BSUKI_BKODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUKI_BKODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUKI_BKODUCK>(arg0, 9, b"STEAMM LP bSUKI-bKoduck", b"STEAMM LP Token bSUKI-bKoduck", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUKI_BKODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUKI_BKODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

