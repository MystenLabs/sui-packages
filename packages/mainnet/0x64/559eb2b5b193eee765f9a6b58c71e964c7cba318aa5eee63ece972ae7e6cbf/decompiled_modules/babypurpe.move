module 0x64559eb2b5b193eee765f9a6b58c71e964c7cba318aa5eee63ece972ae7e6cbf::babypurpe {
    struct BABYPURPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPURPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPURPE>(arg0, 6, b"BABYPURPE", b"BABY PURPLE PEPE", b"Introducing the origin story of Sui Baby Purple Pepe, on a mission to make Sui great again. This token was crafted by the community, for the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1234_9ab7040cc9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPURPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPURPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

