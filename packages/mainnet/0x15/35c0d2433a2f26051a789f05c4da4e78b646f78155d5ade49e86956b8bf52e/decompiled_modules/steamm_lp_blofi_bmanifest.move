module 0x1535c0d2433a2f26051a789f05c4da4e78b646f78155d5ade49e86956b8bf52e::steamm_lp_blofi_bmanifest {
    struct STEAMM_LP_BLOFI_BMANIFEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLOFI_BMANIFEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLOFI_BMANIFEST>(arg0, 9, b"STEAMM LP bLOFI-bmanifest", b"STEAMM LP Token bLOFI-bmanifest", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLOFI_BMANIFEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLOFI_BMANIFEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

