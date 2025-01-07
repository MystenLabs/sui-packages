module 0x5a4187f103af6e969354c78417f44556e92c91d5375f6ce5076eab009633f5c1::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 6, b"BALL", b"BALLS", b"Just BALLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71s_I_Yc_Uv_NKL_1b09da159b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

