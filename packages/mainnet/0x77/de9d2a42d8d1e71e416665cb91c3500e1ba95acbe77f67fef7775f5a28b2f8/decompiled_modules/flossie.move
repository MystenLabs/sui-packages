module 0x77de9d2a42d8d1e71e416665cb91c3500e1ba95acbe77f67fef7775f5a28b2f8::flossie {
    struct FLOSSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOSSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOSSIE>(arg0, 6, b"FLOSSIE", b"THE OLDEST LIVING CAT IN THE WORLD", b"Flossie (born 29 December 1995) is a British domestic cat recognized by Guinness World Records as the oldest living cat as of January 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5x6lxcg7rodr3o32o2mxszofnladhtwmwsnnnkjlysrzcr2ef6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOSSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOSSIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

