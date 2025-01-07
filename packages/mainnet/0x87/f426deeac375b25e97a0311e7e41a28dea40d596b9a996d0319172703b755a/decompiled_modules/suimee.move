module 0x87f426deeac375b25e97a0311e7e41a28dea40d596b9a996d0319172703b755a::suimee {
    struct SUIMEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEE>(arg0, 6, b"SUIMEE", b"SUIMEE THE FISH", b"Suimee is a big fish made up of small fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimee_1db7925b67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

