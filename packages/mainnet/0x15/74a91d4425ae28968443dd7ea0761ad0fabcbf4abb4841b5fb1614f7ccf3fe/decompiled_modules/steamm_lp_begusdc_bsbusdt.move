module 0x1574a91d4425ae28968443dd7ea0761ad0fabcbf4abb4841b5fb1614f7ccf3fe::steamm_lp_begusdc_bsbusdt {
    struct STEAMM_LP_BEGUSDC_BSBUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BEGUSDC_BSBUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BEGUSDC_BSBUSDT>(arg0, 9, b"STEAMM LP begUSDC-bsbUSDT", b"STEAMM LP Token begUSDC-bsbUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BEGUSDC_BSBUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BEGUSDC_BSBUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

