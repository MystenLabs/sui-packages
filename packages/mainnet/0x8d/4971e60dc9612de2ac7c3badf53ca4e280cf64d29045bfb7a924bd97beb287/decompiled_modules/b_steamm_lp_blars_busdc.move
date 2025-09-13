module 0x8d4971e60dc9612de2ac7c3badf53ca4e280cf64d29045bfb7a924bd97beb287::b_steamm_lp_blars_busdc {
    struct B_STEAMM_LP_BLARS_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BLARS_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BLARS_BUSDC>(arg0, 9, b"bSTEAMM LP bLARS-bUSDC", b"bToken STEAMM LP bLARS-bUSDC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BLARS_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BLARS_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

