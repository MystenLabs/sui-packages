module 0xf4e14be4efc400c0a444bbfd88685bc2f46b092137f02c68589f5c284b7f874e::steamm_lp_binu_bausd {
    struct STEAMM_LP_BINU_BAUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BINU_BAUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BINU_BAUSD>(arg0, 9, b"STEAMM LP bINU-bAUSD", b"STEAMM LP Token bINU-bAUSD", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BINU_BAUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BINU_BAUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

