module 0x8f9ab6b122ffb676e5c612d41e699cfd270f65f2b501a7b35a36bec8f20e0bc3::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"BOG ON SUI", b"Look at mi. bog iz the reil cptin now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bogs_0591538c02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

