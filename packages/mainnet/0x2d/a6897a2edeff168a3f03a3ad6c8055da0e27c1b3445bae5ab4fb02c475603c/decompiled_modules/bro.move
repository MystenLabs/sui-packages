module 0x2da6897a2edeff168a3f03a3ad6c8055da0e27c1b3445bae5ab4fb02c475603c::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"Build Robot", b"Strength Intellect Luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028341_c5232c7005.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

