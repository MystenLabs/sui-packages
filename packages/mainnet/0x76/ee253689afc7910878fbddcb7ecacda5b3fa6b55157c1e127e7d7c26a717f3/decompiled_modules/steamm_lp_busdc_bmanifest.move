module 0x76ee253689afc7910878fbddcb7ecacda5b3fa6b55157c1e127e7d7c26a717f3::steamm_lp_busdc_bmanifest {
    struct STEAMM_LP_BUSDC_BMANIFEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDC_BMANIFEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDC_BMANIFEST>(arg0, 9, b"STEAMM LP bUSDC-bmanifest", b"STEAMM LP Token bUSDC-bmanifest", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDC_BMANIFEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDC_BMANIFEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

