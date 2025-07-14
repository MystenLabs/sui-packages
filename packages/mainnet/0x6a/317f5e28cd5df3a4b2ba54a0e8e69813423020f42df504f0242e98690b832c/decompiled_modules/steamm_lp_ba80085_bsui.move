module 0x6a317f5e28cd5df3a4b2ba54a0e8e69813423020f42df504f0242e98690b832c::steamm_lp_ba80085_bsui {
    struct STEAMM_LP_BA80085_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BA80085_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BA80085_BSUI>(arg0, 9, b"STEAMM LP bA80085-bSUI", b"STEAMM LP Token bA80085-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BA80085_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BA80085_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

