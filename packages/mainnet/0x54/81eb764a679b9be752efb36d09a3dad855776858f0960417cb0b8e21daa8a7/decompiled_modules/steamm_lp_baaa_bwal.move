module 0x5481eb764a679b9be752efb36d09a3dad855776858f0960417cb0b8e21daa8a7::steamm_lp_baaa_bwal {
    struct STEAMM_LP_BAAA_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BAAA_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BAAA_BWAL>(arg0, 9, b"STEAMM LP bAAA-bWAL", b"STEAMM LP Token bAAA-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BAAA_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BAAA_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

