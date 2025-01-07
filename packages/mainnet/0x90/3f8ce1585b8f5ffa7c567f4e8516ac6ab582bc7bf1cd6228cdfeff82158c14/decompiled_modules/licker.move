module 0x903f8ce1585b8f5ffa7c567f4e8516ac6ab582bc7bf1cd6228cdfeff82158c14::licker {
    struct LICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICKER>(arg0, 6, b"LICKER", b"Sui Licker", b"Licker - the most disgusting and degenerate form of shitcoin addiction. A bottom feeder in the cesspool of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_000328_3f45721fb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

