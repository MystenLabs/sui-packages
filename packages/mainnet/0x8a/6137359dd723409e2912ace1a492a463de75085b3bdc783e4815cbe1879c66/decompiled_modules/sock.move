module 0x8a6137359dd723409e2912ace1a492a463de75085b3bdc783e4815cbe1879c66::sock {
    struct SOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCK>(arg0, 6, b"SOCK", b"First Cat of the United States", b"Socks (c.1989  February 20, 2009) was the pet cat of the Clinton family, the first family of the United States from 1993 to 2001.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_004332_936_2a7404cccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

