module 0xffc5a47dc74a3e04019d4abf9af580020d3cfe9f965e4e5dd27a80d17b862ada::bolts {
    struct BOLTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLTS>(arg0, 6, b"BOLTs", b"Brett's DOG", x"425245545427732062656c6f76656420646f6720686173206265636f6d652061206368657269736865642069636f6e2077697468696e20686973206c6f79616c207061636b2e0a0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241014_200752_682dd78a09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

