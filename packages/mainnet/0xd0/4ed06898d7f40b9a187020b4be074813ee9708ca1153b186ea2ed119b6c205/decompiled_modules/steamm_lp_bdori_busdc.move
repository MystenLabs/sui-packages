module 0xd04ed06898d7f40b9a187020b4be074813ee9708ca1153b186ea2ed119b6c205::steamm_lp_bdori_busdc {
    struct STEAMM_LP_BDORI_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BDORI_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BDORI_BUSDC>(arg0, 9, b"STEAMM LP bDORI-bUSDC", b"STEAMM LP Token bDORI-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BDORI_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BDORI_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

