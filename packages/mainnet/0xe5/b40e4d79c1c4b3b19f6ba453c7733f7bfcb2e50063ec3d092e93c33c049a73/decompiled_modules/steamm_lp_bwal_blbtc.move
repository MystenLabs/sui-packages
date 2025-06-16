module 0xe5b40e4d79c1c4b3b19f6ba453c7733f7bfcb2e50063ec3d092e93c33c049a73::steamm_lp_bwal_blbtc {
    struct STEAMM_LP_BWAL_BLBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWAL_BLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWAL_BLBTC>(arg0, 9, b"STEAMM LP bWAL-bLBTC", b"STEAMM LP Token bWAL-bLBTC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWAL_BLBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWAL_BLBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

