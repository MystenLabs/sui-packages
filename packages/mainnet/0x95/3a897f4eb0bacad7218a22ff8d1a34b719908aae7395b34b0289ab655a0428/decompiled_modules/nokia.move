module 0x953a897f4eb0bacad7218a22ff8d1a34b719908aae7395b34b0289ab655a0428::nokia {
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

