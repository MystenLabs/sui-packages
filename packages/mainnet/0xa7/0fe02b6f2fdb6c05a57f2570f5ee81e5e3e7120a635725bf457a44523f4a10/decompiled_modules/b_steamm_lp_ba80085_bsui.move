module 0xa70fe02b6f2fdb6c05a57f2570f5ee81e5e3e7120a635725bf457a44523f4a10::b_steamm_lp_ba80085_bsui {
    struct B_STEAMM_LP_BA80085_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BA80085_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BA80085_BSUI>(arg0, 9, b"bSTEAMM LP bA80085-bSUI", b"bToken STEAMM LP bA80085-bSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BA80085_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BA80085_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

