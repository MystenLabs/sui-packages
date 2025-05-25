module 0x95cfc925e169a2661d2eef5231183dc549859187aedc853fb8d8bc609fb5dd8c::steamm_lp_bhawal_bwal {
    struct STEAMM_LP_BHAWAL_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BHAWAL_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BHAWAL_BWAL>(arg0, 9, b"STEAMM LP bhaWAL-bWAL", b"STEAMM LP Token bhaWAL-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BHAWAL_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BHAWAL_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

