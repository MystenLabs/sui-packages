module 0xc2517abdc8efd78f5fe01cfa18ee4dc362628a17a18dbf6120b8d0cc64ee659::steamm_lp_brescue_bup {
    struct STEAMM_LP_BRESCUE_BUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRESCUE_BUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRESCUE_BUP>(arg0, 9, b"STEAMM LP bRESCUE-bUP", b"STEAMM LP Token bRESCUE-bUP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRESCUE_BUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRESCUE_BUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

