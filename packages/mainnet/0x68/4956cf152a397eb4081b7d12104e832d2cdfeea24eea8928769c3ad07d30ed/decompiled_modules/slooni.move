module 0x684956cf152a397eb4081b7d12104e832d2cdfeea24eea8928769c3ad07d30ed::slooni {
    struct SLOONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOONI>(arg0, 6, b"SLOONI", b"Slooni", x"536c6f6f6e692028534c4f4f4e49290a536c6f6f6e6920636f6e71756572696e67205375692d206a6f696e207468652043756c74206e6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/555_d292bb3059.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

