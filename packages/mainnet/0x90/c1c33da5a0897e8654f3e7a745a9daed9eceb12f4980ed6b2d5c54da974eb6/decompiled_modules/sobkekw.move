module 0x90c1c33da5a0897e8654f3e7a745a9daed9eceb12f4980ed6b2d5c54da974eb6::sobkekw {
    struct SOBKEKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBKEKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOBKEKW>(arg0, 6, b"SOBKEKW", b"Crying Kekw", b"Token for degen losers.I always become people exit liquidity. FML", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crying_kekw_e800a48321.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBKEKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBKEKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

