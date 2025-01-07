module 0xba1b5c2ac1d45733360ab22f86000dbc18f6a67152b3e06fda51051797226e0::piupiumeme {
    struct PIUPIUMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIUPIUMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIUPIUMEME>(arg0, 6, b"PIUPIUMEME", b"PIUPIUMeme", b"our lovable accountant with celestial aspirations, invites you on a cosmic journey! By day, he crunches numbers, but by night, he's tinkering away, crafting zany contraptions in his relentless pursuit of touching the lunar surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23452345_7aec782ab3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIUPIUMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIUPIUMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

