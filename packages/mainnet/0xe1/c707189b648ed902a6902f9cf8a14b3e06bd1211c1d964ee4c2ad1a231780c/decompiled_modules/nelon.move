module 0xe1c707189b648ed902a6902f9cf8a14b3e06bd1211c1d964ee4c2ad1a231780c::nelon {
    struct NELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELON>(arg0, 6, b"NELON", b"Nutelon Mars", x"456d627261636520746865206d697373696f6e206f6620636f6e71756572696e67204d617273210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_YR_3_M_Pq7xxg_Zc2ob3q_Ro2g_Ryv6_Uw_Tj79_Z_Tk4_NE_Dv_V_Eji_cb6d07e930.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

