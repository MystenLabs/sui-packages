module 0xc5a85f937f0bd1e408e2255e380c199a427a1a7f2e424b95b7fecf4a8ec13938::steamm_lp_biron_bar_btato {
    struct STEAMM_LP_BIRON_BAR_BTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BIRON_BAR_BTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BIRON_BAR_BTATO>(arg0, 9, b"STEAMM LP bIRON_BAR-bTATO", b"STEAMM LP Token bIRON_BAR-bTATO", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BIRON_BAR_BTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BIRON_BAR_BTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

