module 0x1627677fb24a0b7c0f544e90372ca0c2e1596134fb8c34e670c7435f4eb7ef11::supercat {
    struct SUPERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCAT>(arg0, 6, b"SUPERCAT", b"SUPER CAT SUI", x"546865207374726f6e676573742063617420616c6976652068617320636f6d6520746f205355492e20497427732074696d6520746f2073617665207468652073706163652066726f6d20746865207363756d6d7920636162616c7320616e64206a6565747920677579732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_15_38_05_603cdd7a4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

