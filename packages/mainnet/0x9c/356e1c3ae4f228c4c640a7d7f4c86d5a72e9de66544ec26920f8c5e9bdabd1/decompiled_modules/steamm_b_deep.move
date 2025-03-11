module 0x9c356e1c3ae4f228c4c640a7d7f4c86d5a72e9de66544ec26920f8c5e9bdabd1::steamm_b_deep {
    struct STEAMM_B_DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_B_DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_B_DEEP>(arg0, 9, b"STEAMM bDEEP", b"STEAMM bToken bDEEP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_B_DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_B_DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

