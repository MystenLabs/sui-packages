module 0x927cef68fa537e723c8e5b5b59769fe4c1b1f8fe93accedf4a9005ae1ae44ad8::steamm_lp_bsui_btst {
    struct STEAMM_LP_BSUI_BTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BTST>(arg0, 9, b"STEAMM LP bSUI-bTST", b"STEAMM LP Token bSUI-bTST", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BTST>>(v1);
    }

    // decompiled from Move bytecode v6
}

