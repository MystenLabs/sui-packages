module 0x145cb1f75db86ef3de24b078bdea0e5c2c051939ec017b51367167bedfc46ccf::steamm_lp_bsucall_bssui {
    struct STEAMM_LP_BSUCALL_BSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUCALL_BSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUCALL_BSSUI>(arg0, 9, b"STEAMM LP bSUCALL-bsSUI", b"STEAMM LP Token bSUCALL-bsSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUCALL_BSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUCALL_BSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

