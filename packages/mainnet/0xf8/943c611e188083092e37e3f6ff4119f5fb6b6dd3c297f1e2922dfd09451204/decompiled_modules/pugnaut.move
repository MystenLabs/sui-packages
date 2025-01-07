module 0xf8943c611e188083092e37e3f6ff4119f5fb6b6dd3c297f1e2922dfd09451204::pugnaut {
    struct PUGNAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGNAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGNAUT>(arg0, 6, b"PUGNAUT", b"PUGSTRONAUT", x"4d6f6f6e206d697373696f6e2069732074656d706f726172696c79206f6e20686f6c642e20546865205355492065636f73797374656d2077696c6c207072657661696c2c20616e64206f7574706572666f726d20746865206d61726b65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zd_AYD_7_Wk_A_Ak_H_Lp_0437f15a66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGNAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGNAUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

