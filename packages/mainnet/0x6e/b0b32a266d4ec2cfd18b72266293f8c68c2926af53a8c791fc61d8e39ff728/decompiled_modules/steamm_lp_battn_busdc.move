module 0x6eb0b32a266d4ec2cfd18b72266293f8c68c2926af53a8c791fc61d8e39ff728::steamm_lp_battn_busdc {
    struct STEAMM_LP_BATTN_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BATTN_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BATTN_BUSDC>(arg0, 9, b"STEAMM LP bATTN-bUSDC", b"STEAMM LP Token bATTN-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BATTN_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BATTN_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

