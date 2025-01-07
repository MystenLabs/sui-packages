module 0xee4801bd21e0830df2b42d4b35b06e9ffbd3b8e3c16112d2ee110509113cfe6e::mrug {
    struct MRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRUG>(arg0, 6, b"MRUG", b"Meow Rug", b"MEEEEOOOWWWWWWRRRRUUUUGGGGGGG!!!!! Its a RUGG!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mrug_6cd580b46c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

