module 0x247d126d45c5c7ade391bd82ef3e9279b94b2e6f5bddc71b1db27036c1bbe1ad::steamm_lp_bsend_bbuck {
    struct STEAMM_LP_BSEND_BBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSEND_BBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSEND_BBUCK>(arg0, 9, b"STEAMM LP bSEND-bBUCK", b"STEAMM LP Token bSEND-bBUCK", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSEND_BBUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSEND_BBUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

