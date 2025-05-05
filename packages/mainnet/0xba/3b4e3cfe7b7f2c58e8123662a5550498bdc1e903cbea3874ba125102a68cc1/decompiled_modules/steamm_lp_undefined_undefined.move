module 0xba3b4e3cfe7b7f2c58e8123662a5550498bdc1e903cbea3874ba125102a68cc1::steamm_lp_undefined_undefined {
    struct STEAMM_LP_UNDEFINED_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_UNDEFINED_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_UNDEFINED_UNDEFINED>(arg0, 9, b"STEAMM LP undefined-undefined", b"STEAMM LP Token undefined-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_UNDEFINED_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_UNDEFINED_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

