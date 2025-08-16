module 0x41a03136fea3f1b394950b344fd1080af3e7734dfe8fae435888a98303659b9f::steamm_lp_bpumpkin_bcabal {
    struct STEAMM_LP_BPUMPKIN_BCABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPUMPKIN_BCABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPUMPKIN_BCABAL>(arg0, 9, b"STEAMM LP bPUMPKIN-bCABAL", b"STEAMM LP Token bPUMPKIN-bCABAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPUMPKIN_BCABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPUMPKIN_BCABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

