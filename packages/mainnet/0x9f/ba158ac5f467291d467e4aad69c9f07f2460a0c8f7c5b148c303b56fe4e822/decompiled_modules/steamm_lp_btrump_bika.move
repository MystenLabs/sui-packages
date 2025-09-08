module 0x9fba158ac5f467291d467e4aad69c9f07f2460a0c8f7c5b148c303b56fe4e822::steamm_lp_btrump_bika {
    struct STEAMM_LP_BTRUMP_BIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTRUMP_BIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTRUMP_BIKA>(arg0, 9, b"STEAMM LP bTRUMP-bIKA", b"STEAMM LP Token bTRUMP-bIKA", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTRUMP_BIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTRUMP_BIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

