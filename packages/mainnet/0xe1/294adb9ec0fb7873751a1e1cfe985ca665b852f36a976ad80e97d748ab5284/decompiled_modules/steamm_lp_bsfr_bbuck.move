module 0xe1294adb9ec0fb7873751a1e1cfe985ca665b852f36a976ad80e97d748ab5284::steamm_lp_bsfr_bbuck {
    struct STEAMM_LP_BSFR_BBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSFR_BBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSFR_BBUCK>(arg0, 9, b"STEAMM LP bSFR-bBUCK", b"STEAMM LP Token bSFR-bBUCK", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSFR_BBUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSFR_BBUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

