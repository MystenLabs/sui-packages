module 0x5dbad05bfa9c77306bce93a1285bb5e5c36204422800c13603acf0f23011e9a9::steamm_lp_wsui_wusdc {
    struct STEAMM_LP_WSUI_WUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_WSUI_WUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_WSUI_WUSDC>(arg0, 9, b"STEAMM LP WSUI-WUSDC", b"STEAMM_LP WSUI-WUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_WSUI_WUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_WSUI_WUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

