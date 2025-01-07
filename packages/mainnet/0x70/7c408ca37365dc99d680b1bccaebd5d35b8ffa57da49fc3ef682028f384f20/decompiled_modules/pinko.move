module 0x707c408ca37365dc99d680b1bccaebd5d35b8ffa57da49fc3ef682028f384f20::pinko {
    struct PINKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKO>(arg0, 6, b"PINKO", b"Pinko by Matt Furie", b"Pinko is a full time degen, on a quest to become the 5th member of the boys club. Is it pink?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PINKO_0561a3f5c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

