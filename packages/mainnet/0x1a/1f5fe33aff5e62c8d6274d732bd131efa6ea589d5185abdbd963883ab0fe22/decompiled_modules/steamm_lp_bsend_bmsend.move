module 0x1a1f5fe33aff5e62c8d6274d732bd131efa6ea589d5185abdbd963883ab0fe22::steamm_lp_bsend_bmsend {
    struct STEAMM_LP_BSEND_BMSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSEND_BMSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSEND_BMSEND>(arg0, 9, b"STEAMM LP bSEND-bmSEND", b"STEAMM LP Token bSEND-bmSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSEND_BMSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSEND_BMSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

