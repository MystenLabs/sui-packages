module 0x60d88224db5e65d14ca3400e170bfae72b172a8063c8782ffa24f0b4d7e5e18f::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Captain GOOFY", x"41686f792c207361696c6f727321200a0a57656c636f6d652061626f6172642120486572657320796f7572206d617020746f206e61766967617465207468726f756768206f7572207761746572733a0a0a204361746368207573206f6e3a2068747470733a2f2f782e636f6d2f476f6f66795f7375690a20436f6d6d756e696361746520696e2054656c656772616d207669613a2068747470733a2f2f742e6d652f4361707461696e474f4f46790a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sf_Y01_K6_C_400x400_aadbad185b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

