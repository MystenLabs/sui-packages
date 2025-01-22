module 0x9782cd230af83ae5508153642cd6499b61bb33e4d70a3b97db97ab8cbfa190d6::violet {
    struct VIOLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIOLET>(arg0, 6, b"VIOLET", b"Violet by SuiAI", x"2456494f4c455420e28094207265766f6c7574696f6e697a696e672063727970746f20616e616c797369732c20746f6b656e20646973636f766572792c20616e64206f6e2d636861696e206461746120696e74656c6c6967656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2224_2e5e1285c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIOLET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOLET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

