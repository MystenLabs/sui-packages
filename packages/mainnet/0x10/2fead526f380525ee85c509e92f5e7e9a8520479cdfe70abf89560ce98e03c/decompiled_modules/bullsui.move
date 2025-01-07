module 0x102fead526f380525ee85c509e92f5e7e9a8520479cdfe70abf89560ce98e03c::bullsui {
    struct BULLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSUI>(arg0, 6, b"BULLSUI", b"BULLISH", x"42554c495348204f4e205355490a0a5349434b204f4620414c4c20544845204641524d4552530a0a5341464520484f4e455354205445414d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullishlogo_f2d0bc604c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

