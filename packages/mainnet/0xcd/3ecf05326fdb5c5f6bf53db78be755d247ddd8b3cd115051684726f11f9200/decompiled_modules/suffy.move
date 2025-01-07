module 0xcd3ecf05326fdb5c5f6bf53db78be755d247ddd8b3cd115051684726f11f9200::suffy {
    struct SUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUFFY>(arg0, 6, b"SUFFY", b"SUI LUFFY", x"4a6f696e2053554659206f6e20686973207472616e73666f726d6174696f6e2066726f6d206b696e67206f6620746865207069726174657320746f20535549206b696e67206f6620746865207365612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_08_41_a0a82d4550.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

