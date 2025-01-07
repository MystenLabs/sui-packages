module 0x7c137f2f9de43b6738f8d8bda015b1e7f09583680bf4320aeb012a49b3f5a7e7::suigoblin {
    struct SUIGOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOBLIN>(arg0, 6, b"SUIGOBLIN", b"Sui Goblin", b"Sui Goblin. The sneaky thief of the Sui network. Always lurking, always taking, this goblins here to grab whats his.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_64_1_210116f37b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

