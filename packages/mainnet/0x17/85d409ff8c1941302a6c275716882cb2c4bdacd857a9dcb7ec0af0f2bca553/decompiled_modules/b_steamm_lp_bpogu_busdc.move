module 0x1785d409ff8c1941302a6c275716882cb2c4bdacd857a9dcb7ec0af0f2bca553::b_steamm_lp_bpogu_busdc {
    struct B_STEAMM_LP_BPOGU_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BPOGU_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BPOGU_BUSDC>(arg0, 9, b"bSTEAMM LP bPOGU-bUSDC", b"bToken STEAMM LP bPOGU-bUSDC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BPOGU_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BPOGU_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

