module 0xf762cd993fea871046205735dcb13995cad2275ea86c6039f10d0f5b4668367c::steamm_lp_bwhale_bkoduck {
    struct STEAMM_LP_BWHALE_BKODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWHALE_BKODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWHALE_BKODUCK>(arg0, 9, b"STEAMM LP bWHALE-bKoduck", b"STEAMM LP Token bWHALE-bKoduck", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWHALE_BKODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWHALE_BKODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

