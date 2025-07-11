module 0xee133ba63b8343b6ed6af1a31b53c3f0fb24cc54fea6db6550f36f8ba97baea4::steamm_lp_busdt_beth {
    struct STEAMM_LP_BUSDT_BETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDT_BETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDT_BETH>(arg0, 9, b"STEAMM LP bUSDT-bETH", b"STEAMM LP Token bUSDT-bETH", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDT_BETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDT_BETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

