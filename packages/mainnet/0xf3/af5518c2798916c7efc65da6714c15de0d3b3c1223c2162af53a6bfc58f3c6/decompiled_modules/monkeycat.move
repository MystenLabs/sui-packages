module 0xf3af5518c2798916c7efc65da6714c15de0d3b3c1223c2162af53a6bfc58f3c6::monkeycat {
    struct MONKEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYCAT>(arg0, 6, b"MONKEYCAT", b"MONKEYCAT SUI", b"Swings by day, purrs by night. The $MONKEYCAT is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_14_07_22_c7513a1e46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

