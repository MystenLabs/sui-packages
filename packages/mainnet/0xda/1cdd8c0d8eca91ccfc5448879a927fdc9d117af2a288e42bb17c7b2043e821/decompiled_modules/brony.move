module 0xda1cdd8c0d8eca91ccfc5448879a927fdc9d117af2a288e42bb17c7b2043e821::brony {
    struct BRONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRONY>(arg0, 6, b"Brony", b"Brony Alliance", b"Brony Alliance is a meme coin on the SUI blockchain. The token features the community named Derpy Hooves from the series My Little Pony: Friendship is Magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054466_e3a9c86262.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

