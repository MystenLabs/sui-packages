module 0xa5a9f11065711c6e98bc989a1189408c6eac1eadba5c1c395805b421a40e6405::steamm_lp_battn_bsend {
    struct STEAMM_LP_BATTN_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BATTN_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BATTN_BSEND>(arg0, 9, b"STEAMM LP bATTN-bSEND", b"STEAMM LP Token bATTN-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BATTN_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BATTN_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

