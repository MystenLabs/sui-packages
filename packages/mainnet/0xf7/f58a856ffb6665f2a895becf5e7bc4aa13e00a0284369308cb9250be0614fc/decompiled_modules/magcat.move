module 0xf7f58a856ffb6665f2a895becf5e7bc4aa13e00a0284369308cb9250be0614fc::magcat {
    struct MAGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGCAT>(arg0, 6, b"MAGCAT", b"Magic Cat", x"57656c636f6d6520746f20746865206d61676963616c20776f726c64206f66204d616743617421200a57657265206e6f74206a75737420616e792063727970746f7765766520676f7420776869736b6572732c207370656c6c732c20616e64206120746f756368206f662066656c696e65206d697363686965662e20537461792074756e656420666f7220707572726665637420757064617465732c20616e64206c657473206d616b6520736f6d65206d6167696320746f6765746865722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026450_274505989d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

