module 0xe169e38dfcb8f3cc36bf4f908fe73c5c7b820407b238d8c4dc4a2a3367954f65::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MEW ON SUI", x"546865204c6567656e64617279204d65772e0a54656c656772616d3a2068747470733a2f2f742e6d652f6d65775f6f6e5f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3x9_F1_Ub_G_400x400_78049bd0b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

