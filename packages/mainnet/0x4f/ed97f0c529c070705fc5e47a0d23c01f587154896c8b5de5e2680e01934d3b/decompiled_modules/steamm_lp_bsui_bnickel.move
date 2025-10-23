module 0x4fed97f0c529c070705fc5e47a0d23c01f587154896c8b5de5e2680e01934d3b::steamm_lp_bsui_bnickel {
    struct STEAMM_LP_BSUI_BNICKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BNICKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BNICKEL>(arg0, 9, b"STEAMM LP bSUI-bNICKEL", b"STEAMM LP Token bSUI-bNICKEL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BNICKEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BNICKEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

