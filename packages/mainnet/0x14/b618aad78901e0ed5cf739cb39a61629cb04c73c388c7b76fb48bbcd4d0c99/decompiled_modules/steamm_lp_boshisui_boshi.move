module 0x14b618aad78901e0ed5cf739cb39a61629cb04c73c388c7b76fb48bbcd4d0c99::steamm_lp_boshisui_boshi {
    struct STEAMM_LP_BOSHISUI_BOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOSHISUI_BOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOSHISUI_BOSHI>(arg0, 9, b"STEAMM LP boshiSUI-bOSHI", b"STEAMM LP Token boshiSUI-bOSHI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOSHISUI_BOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOSHISUI_BOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

