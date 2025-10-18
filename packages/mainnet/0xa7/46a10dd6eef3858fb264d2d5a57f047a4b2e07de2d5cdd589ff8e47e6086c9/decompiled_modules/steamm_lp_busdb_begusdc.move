module 0xa746a10dd6eef3858fb264d2d5a57f047a4b2e07de2d5cdd589ff8e47e6086c9::steamm_lp_busdb_begusdc {
    struct STEAMM_LP_BUSDB_BEGUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDB_BEGUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDB_BEGUSDC>(arg0, 9, b"STEAMM LP bUSDB-begUSDC", b"STEAMM LP Token bUSDB-begUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDB_BEGUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDB_BEGUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

