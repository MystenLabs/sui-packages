module 0xb0d435f3d63a16ff34c5230ca60101ef3ce37d73a6c9bf420fda3137359fc763::mrug {
    struct MRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRUG>(arg0, 6, b"MRUG", b"Meow Rug", b"MEEEEOOOWWWWWWRRRRUUUUGGGGGGG!!!!! Its a RUGG!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734969329109.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

