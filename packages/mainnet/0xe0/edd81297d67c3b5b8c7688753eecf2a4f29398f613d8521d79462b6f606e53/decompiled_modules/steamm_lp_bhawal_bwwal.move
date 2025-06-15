module 0xe0edd81297d67c3b5b8c7688753eecf2a4f29398f613d8521d79462b6f606e53::steamm_lp_bhawal_bwwal {
    struct STEAMM_LP_BHAWAL_BWWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BHAWAL_BWWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BHAWAL_BWWAL>(arg0, 9, b"STEAMM LP bhaWAL-bwWAL", b"STEAMM LP Token bhaWAL-bwWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BHAWAL_BWWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BHAWAL_BWWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

