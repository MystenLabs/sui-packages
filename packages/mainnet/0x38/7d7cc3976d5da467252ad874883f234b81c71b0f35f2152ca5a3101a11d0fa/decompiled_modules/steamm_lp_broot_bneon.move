module 0x387d7cc3976d5da467252ad874883f234b81c71b0f35f2152ca5a3101a11d0fa::steamm_lp_broot_bneon {
    struct STEAMM_LP_BROOT_BNEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BROOT_BNEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BROOT_BNEON>(arg0, 9, b"STEAMM LP bROOT-bNEON", b"STEAMM LP Token bROOT-bNEON", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BROOT_BNEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BROOT_BNEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

