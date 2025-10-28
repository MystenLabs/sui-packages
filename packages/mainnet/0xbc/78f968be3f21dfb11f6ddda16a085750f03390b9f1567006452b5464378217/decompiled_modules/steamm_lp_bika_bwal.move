module 0xbc78f968be3f21dfb11f6ddda16a085750f03390b9f1567006452b5464378217::steamm_lp_bika_bwal {
    struct STEAMM_LP_BIKA_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BIKA_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BIKA_BWAL>(arg0, 9, b"STEAMM LP bIKA-bWAL", b"STEAMM LP Token bIKA-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BIKA_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BIKA_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

