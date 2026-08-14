module 0xbaddee1ab3e8adca4aac4136d7c0b0d98e7de29c358b857fb5d83774a1df147a::steamm_lp_bcashcat_busdc {
    struct STEAMM_LP_BCASHCAT_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BCASHCAT_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BCASHCAT_BUSDC>(arg0, 9, b"STEAMM LP bCASHCAT-bUSDC", b"STEAMM LP Token bCASHCAT-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BCASHCAT_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BCASHCAT_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

