module 0x57d3892bc0b88cd20d19a418eccbb9615d4c86495a901dfa7ae626afb708ea3::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"Suirtle", b"Suirtle, the loyal and energetic crypto guide, here to lead you through the blockchain world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040089_cd7123a402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

