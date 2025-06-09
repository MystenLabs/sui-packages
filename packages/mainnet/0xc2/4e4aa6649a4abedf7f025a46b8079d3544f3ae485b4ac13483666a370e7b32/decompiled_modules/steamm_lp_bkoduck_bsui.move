module 0xc24e4aa6649a4abedf7f025a46b8079d3544f3ae485b4ac13483666a370e7b32::steamm_lp_bkoduck_bsui {
    struct STEAMM_LP_BKODUCK_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKODUCK_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKODUCK_BSUI>(arg0, 9, b"STEAMM LP bKoduck-bSUI", b"STEAMM LP Token bKoduck-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKODUCK_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKODUCK_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

