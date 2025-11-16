module 0x136301f767569b94984ac711e2ac9bf75eb81fa6a02c6c5cc64b5c48af3a5924::steamm_lp_bhoss_bika {
    struct STEAMM_LP_BHOSS_BIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BHOSS_BIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BHOSS_BIKA>(arg0, 9, b"STEAMM LP bHoss-bIKA", b"STEAMM LP Token bHoss-bIKA", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BHOSS_BIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BHOSS_BIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

