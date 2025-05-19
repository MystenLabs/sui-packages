module 0xf42a19014d8c18450efbc89f0541abd9cce8313cc9092016c458fef150c35c9c::steamm_lp_bwal_busdc {
    struct STEAMM_LP_BWAL_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWAL_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWAL_BUSDC>(arg0, 9, b"STEAMM LP bWAL-bUSDC", b"STEAMM LP Token bWAL-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWAL_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWAL_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

