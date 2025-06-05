module 0x2f199e8cdf06c456a0396c74ada31256456bc3ce147393b4b1377f601f325cfd::steamm_lp_bbwal_bwal {
    struct STEAMM_LP_BBWAL_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBWAL_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBWAL_BWAL>(arg0, 9, b"STEAMM LP bBWAL-bWAL", b"STEAMM LP Token bBWAL-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBWAL_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBWAL_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

