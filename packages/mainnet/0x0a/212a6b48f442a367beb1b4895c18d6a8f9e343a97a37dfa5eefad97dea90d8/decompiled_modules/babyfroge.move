module 0xa212a6b48f442a367beb1b4895c18d6a8f9e343a97a37dfa5eefad97dea90d8::babyfroge {
    struct BABYFROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFROGE>(arg0, 6, b"BABYFROGE", b"Baby Froge", x"46524f4745206973207468652022556e6f6666696369616c22204f6666696369616c204d6173636f7420666f72204f70656e4169202d20546865204e6f2e312046726f6720696e205765623320467574757265206f662043727970746f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_9abe0ec583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

