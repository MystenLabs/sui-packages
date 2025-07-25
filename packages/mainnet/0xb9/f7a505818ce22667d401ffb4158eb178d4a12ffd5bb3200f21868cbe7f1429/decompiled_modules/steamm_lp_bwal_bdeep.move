module 0xb9f7a505818ce22667d401ffb4158eb178d4a12ffd5bb3200f21868cbe7f1429::steamm_lp_bwal_bdeep {
    struct STEAMM_LP_BWAL_BDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWAL_BDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWAL_BDEEP>(arg0, 9, b"STEAMM LP bWAL-bDEEP", b"STEAMM LP Token bWAL-bDEEP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWAL_BDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWAL_BDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

