module 0x84e9fa201bf8ebd12122f3ef49460dd674524010f013b5e23a3dcf28d430e64::steamm_lp_brescue_bika {
    struct STEAMM_LP_BRESCUE_BIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRESCUE_BIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRESCUE_BIKA>(arg0, 9, b"STEAMM LP bRESCUE-bIKA", b"STEAMM LP Token bRESCUE-bIKA", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRESCUE_BIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRESCUE_BIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

