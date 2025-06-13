module 0xd83b456b209d5c9e33b170374afef686583fefaaba75d384ca5c5f5b35697b2d::steamm_lp_bnft_bwal {
    struct STEAMM_LP_BNFT_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BNFT_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BNFT_BWAL>(arg0, 9, b"STEAMM LP bNFT-bWAL", b"STEAMM LP Token bNFT-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BNFT_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BNFT_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

