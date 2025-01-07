module 0x36240fa9ee7beafe30721bf0b0ea638689a7ed10c3f6b1d163bb4082c7612c4a::dota {
    struct DOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTA>(arg0, 6, b"DOTA", b"DOTA COIN", b"nique cryptocurrency integrated with updates (patches) of DOTA 2 game on SUI eco system. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logopng256_17c1a3b687.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

