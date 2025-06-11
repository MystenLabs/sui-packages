module 0x1d80e4346a400c33cd6994f5919c47703eb55b68c5ba92edf5fb1bc4388cc1f9::steamm_lp_brescue_bwal {
    struct STEAMM_LP_BRESCUE_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRESCUE_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRESCUE_BWAL>(arg0, 9, b"STEAMM LP bRESCUE-bWAL", b"STEAMM LP Token bRESCUE-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRESCUE_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRESCUE_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

