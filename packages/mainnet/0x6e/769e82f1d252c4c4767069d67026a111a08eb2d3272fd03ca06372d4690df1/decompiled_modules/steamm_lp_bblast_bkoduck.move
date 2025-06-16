module 0x6e769e82f1d252c4c4767069d67026a111a08eb2d3272fd03ca06372d4690df1::steamm_lp_bblast_bkoduck {
    struct STEAMM_LP_BBLAST_BKODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBLAST_BKODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBLAST_BKODUCK>(arg0, 9, b"STEAMM LP bBlast-bKoduck", b"STEAMM LP Token bBlast-bKoduck", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBLAST_BKODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBLAST_BKODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

