module 0x302e0477884791cdb3549236e7a2bc91b05828340f5fc008c61f0f6d98976ea6::steamm_lp_bpeng_bsui {
    struct STEAMM_LP_BPENG_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPENG_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPENG_BSUI>(arg0, 9, b"STEAMM LP bPENG-bSUI", b"STEAMM LP Token bPENG-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPENG_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPENG_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

