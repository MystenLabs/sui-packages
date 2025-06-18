module 0x85dd33f340d5621b52b95e7554c85e73d414b0f412a4e86114d8f3a7491e5431::steamm_lp_bkoduck_bzengar {
    struct STEAMM_LP_BKODUCK_BZENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKODUCK_BZENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKODUCK_BZENGAR>(arg0, 9, b"STEAMM LP bKoduck-bZENGAR", b"STEAMM LP Token bKoduck-bZENGAR", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKODUCK_BZENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKODUCK_BZENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

