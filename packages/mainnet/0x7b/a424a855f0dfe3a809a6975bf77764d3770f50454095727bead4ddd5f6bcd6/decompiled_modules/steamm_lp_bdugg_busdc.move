module 0x7ba424a855f0dfe3a809a6975bf77764d3770f50454095727bead4ddd5f6bcd6::steamm_lp_bdugg_busdc {
    struct STEAMM_LP_BDUGG_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BDUGG_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BDUGG_BUSDC>(arg0, 9, b"STEAMM LP bDUGG-bUSDC", b"STEAMM LP Token bDUGG-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BDUGG_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BDUGG_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

