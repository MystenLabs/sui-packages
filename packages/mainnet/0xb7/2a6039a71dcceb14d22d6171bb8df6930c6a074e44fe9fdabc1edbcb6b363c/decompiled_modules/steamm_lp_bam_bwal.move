module 0xb72a6039a71dcceb14d22d6171bb8df6930c6a074e44fe9fdabc1edbcb6b363c::steamm_lp_bam_bwal {
    struct STEAMM_LP_BAM_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BAM_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BAM_BWAL>(arg0, 9, b"STEAMM LP bAM-bWAL", b"STEAMM LP Token bAM-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BAM_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BAM_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

