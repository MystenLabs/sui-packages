module 0x940aee60744720e7d63af4b180c1f6c33f6a7ff3f7f5ad9f655e169b60af6001::steamm_lp_busdb_busdc {
    struct STEAMM_LP_BUSDB_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDB_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDB_BUSDC>(arg0, 9, b"STEAMM LP bUSDB-bUSDC", b"STEAMM LP Token bUSDB-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDB_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDB_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

