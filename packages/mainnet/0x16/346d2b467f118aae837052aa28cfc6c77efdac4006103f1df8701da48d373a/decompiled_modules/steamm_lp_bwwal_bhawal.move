module 0x16346d2b467f118aae837052aa28cfc6c77efdac4006103f1df8701da48d373a::steamm_lp_bwwal_bhawal {
    struct STEAMM_LP_BWWAL_BHAWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWWAL_BHAWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWWAL_BHAWAL>(arg0, 9, b"STEAMM LP bwWAL-bhaWAL", b"STEAMM LP Token bwWAL-bhaWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWWAL_BHAWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWWAL_BHAWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

