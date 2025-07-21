module 0x92b93899f61f0e292431aa5af5ba5b90d459fd1ebe3bbafb1860e038bdf4c01f::steamm_lp_bocto_bmsend {
    struct STEAMM_LP_BOCTO_BMSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOCTO_BMSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOCTO_BMSEND>(arg0, 9, b"STEAMM LP bOCTO-bmSEND", b"STEAMM LP Token bOCTO-bmSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOCTO_BMSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOCTO_BMSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

