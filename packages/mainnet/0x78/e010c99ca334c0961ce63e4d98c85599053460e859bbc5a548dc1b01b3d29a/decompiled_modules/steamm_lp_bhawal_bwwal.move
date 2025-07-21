module 0x78e010c99ca334c0961ce63e4d98c85599053460e859bbc5a548dc1b01b3d29a::steamm_lp_bhawal_bwwal {
    struct STEAMM_LP_BHAWAL_BWWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BHAWAL_BWWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BHAWAL_BWWAL>(arg0, 9, b"STEAMM LP bhaWAL-bwWAL", b"STEAMM LP Token bhaWAL-bwWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BHAWAL_BWWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BHAWAL_BWWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

