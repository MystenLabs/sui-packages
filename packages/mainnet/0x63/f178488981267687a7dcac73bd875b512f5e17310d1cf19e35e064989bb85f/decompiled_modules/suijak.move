module 0x63f178488981267687a7dcac73bd875b512f5e17310d1cf19e35e064989bb85f::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 6, b"SUIJAK", b"Suijak", b"$SUIJAK is world-famous and on the road a lot. Take a look at our media section and get a feel for his lifestyle. From brokie to multi-millionaire thanks to SUI-CHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suijak_f400045a7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

