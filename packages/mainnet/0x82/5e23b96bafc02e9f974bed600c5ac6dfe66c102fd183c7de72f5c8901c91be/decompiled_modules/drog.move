module 0x825e23b96bafc02e9f974bed600c5ac6dfe66c102fd183c7de72f5c8901c91be::drog {
    struct DROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROG>(arg0, 6, b"DROG", b"CTO DOG SUI", b"CTO DOG MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ij4k_Jw_Y7rs_J6xb_N_Ft_Ky0qv_Z3_WBU_deadd0f6c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

