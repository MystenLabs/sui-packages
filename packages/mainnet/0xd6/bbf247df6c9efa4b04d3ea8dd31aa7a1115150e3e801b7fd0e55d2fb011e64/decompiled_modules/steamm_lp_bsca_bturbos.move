module 0xd6bbf247df6c9efa4b04d3ea8dd31aa7a1115150e3e801b7fd0e55d2fb011e64::steamm_lp_bsca_bturbos {
    struct STEAMM_LP_BSCA_BTURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSCA_BTURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSCA_BTURBOS>(arg0, 9, b"STEAMM LP bSCA-bTURBOS", b"STEAMM LP Token bSCA-bTURBOS", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSCA_BTURBOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSCA_BTURBOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

