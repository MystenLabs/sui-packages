module 0xfd8acd6085d1967801748629d5a9f1c2279cd97434b6817d6906d143a60e07f0::steamm_lp_bmsend_bmsend {
    struct STEAMM_LP_BMSEND_BMSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMSEND_BMSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMSEND_BMSEND>(arg0, 9, b"STEAMM LP bmSEND-bmSEND", b"STEAMM LP Token bmSEND-bmSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMSEND_BMSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMSEND_BMSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

