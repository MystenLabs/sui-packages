module 0xbed85759a70b5ffc8fb16e1e2a648d9b1dcff9f11a9beedb12fd14e89dab8e45::steamm_lp_bttt_bsend {
    struct STEAMM_LP_BTTT_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTTT_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTTT_BSEND>(arg0, 9, b"STEAMM LP bTTT-bSEND", b"STEAMM LP Token bTTT-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTTT_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTTT_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

