module 0x68abaa76352bb9a57ef2355daab91acbf10fcae50ee8a92e02e70c704932b9bf::b_steamm_lp_bsui_blars {
    struct B_STEAMM_LP_BSUI_BLARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BSUI_BLARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BSUI_BLARS>(arg0, 9, b"bSTEAMM LP bSUI-bLARS", b"bToken STEAMM LP bSUI-bLARS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BSUI_BLARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BSUI_BLARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

