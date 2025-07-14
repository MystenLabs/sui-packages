module 0xa6ae36ec1b4ef73ebce4445559441bcd6af6c52a02570051aeec4b0f98300042::steamm_lp_bballs_battn {
    struct STEAMM_LP_BBALLS_BATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBALLS_BATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBALLS_BATTN>(arg0, 9, b"STEAMM LP bBALLS-bATTN", b"STEAMM LP Token bBALLS-bATTN", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBALLS_BATTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBALLS_BATTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

