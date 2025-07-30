module 0xb4b44c2b06ea52314f8bf5acf594c199b786faf3d4df08b6fdf9b70aaf01ef5b::steamm_lp_bprobandi_bsui {
    struct STEAMM_LP_BPROBANDI_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPROBANDI_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPROBANDI_BSUI>(arg0, 9, b"STEAMM LP bPROBANDI-bSUI", b"STEAMM LP Token bPROBANDI-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPROBANDI_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPROBANDI_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

