module 0x7cd6d8b64adebc757f5509906f7eeb5c7399a96148dbd0f4812e292aa767e39::steamm_lp_bwwal_bwal {
    struct STEAMM_LP_BWWAL_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWWAL_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWWAL_BWAL>(arg0, 9, b"STEAMM LP bwWAL-bWAL", b"STEAMM LP Token bwWAL-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWWAL_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWWAL_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

