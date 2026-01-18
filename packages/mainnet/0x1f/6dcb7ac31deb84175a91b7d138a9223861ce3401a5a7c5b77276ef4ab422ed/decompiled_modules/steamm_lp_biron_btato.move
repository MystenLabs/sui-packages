module 0x1f6dcb7ac31deb84175a91b7d138a9223861ce3401a5a7c5b77276ef4ab422ed::steamm_lp_biron_btato {
    struct STEAMM_LP_BIRON_BTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BIRON_BTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BIRON_BTATO>(arg0, 9, b"STEAMM LP bIRON-bTATO", b"STEAMM LP Token bIRON-bTATO", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BIRON_BTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BIRON_BTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

