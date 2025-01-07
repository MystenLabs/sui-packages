module 0xb80d4425af7aa74e0102e3f1aec358f013b18293c0fc981160891f6297ef7336::drcat {
    struct DRCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRCAT>(arg0, 6, b"DRCAT", b"Dr. Cat", x"4375746520616e64206d6f6465726e2c2044722e20436174206973207468652070657266656374206d656d6520746f20636f6e71756572207468652053554920436861696e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_21_41_18_b536020580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

