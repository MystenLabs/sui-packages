module 0x85810d8369d2f6a92543f710ed9850356b8d87d1aa251f01ae9e4254d363508f::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"TOTODILE", b"Totodile is the most lovely pet in pokeverse, and $TOTO is bringin a good luck in all of his holders. We love $TOTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_88d9c4c9ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

