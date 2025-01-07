module 0x2df7f5a1e7d09dfcf9e0cfe86ceacfff23cd58f48bf480a78531ca1c9b6e6427::mows {
    struct MOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWS>(arg0, 6, b"MOWS", b"Meme Of Wall Street", b"A SUI Meme coin, inspired by one of the most iconic movie on money! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Leonardo_Di_Caprio_in_a_sleek_black_suit_laugh_0_afbb7f0070.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

