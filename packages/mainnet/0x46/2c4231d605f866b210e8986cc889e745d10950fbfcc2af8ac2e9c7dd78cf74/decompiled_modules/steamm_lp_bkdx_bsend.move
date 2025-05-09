module 0x462c4231d605f866b210e8986cc889e745d10950fbfcc2af8ac2e9c7dd78cf74::steamm_lp_bkdx_bsend {
    struct STEAMM_LP_BKDX_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKDX_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKDX_BSEND>(arg0, 9, b"STEAMM LP bKDX-bSEND", b"STEAMM LP Token bKDX-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKDX_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKDX_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

