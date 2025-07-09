module 0x1a50b03b0be1e6aa6e92467b109ad036644006198c9e6f5b7ee72249691f4cf9::steamm_lp_bok_bcray {
    struct STEAMM_LP_BOK_BCRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOK_BCRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOK_BCRAY>(arg0, 9, b"STEAMM LP bOK-bCRAY", b"STEAMM LP Token bOK-bCRAY", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOK_BCRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOK_BCRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

