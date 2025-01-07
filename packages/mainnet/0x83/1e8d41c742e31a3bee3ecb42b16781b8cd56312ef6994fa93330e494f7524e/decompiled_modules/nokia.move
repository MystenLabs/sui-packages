module 0x831e8d41c742e31a3bee3ecb42b16781b8cd56312ef6994fa93330e494f7524e::nokia {
    struct NOKIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOKIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOKIA>(arg0, 6, b"NOKIA", b"NOKIA 3310 ON SUI", b"3310 IS ROCK MOBILE PERFECT FOR SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/360_F_308271562_h7b_E_Di_NW_Mz75n_C0puq5b_G_Hq_Pfp5_Qjxh_G_995cea3ab0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOKIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOKIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

