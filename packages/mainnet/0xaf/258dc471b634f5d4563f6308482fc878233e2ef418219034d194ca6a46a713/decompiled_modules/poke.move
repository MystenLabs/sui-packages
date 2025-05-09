module 0xaf258dc471b634f5d4563f6308482fc878233e2ef418219034d194ca6a46a713::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"POKE", b"Pokesui", b"Pokesui is a blockchain adventure where trainers capture digital Pokmon, trade with $Pokesui tokens, and battle in cosmic arenas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000089308_453c01e1d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

