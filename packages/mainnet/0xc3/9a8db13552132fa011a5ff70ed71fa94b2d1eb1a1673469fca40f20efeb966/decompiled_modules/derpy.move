module 0xc39a8db13552132fa011a5ff70ed71fa94b2d1eb1a1673469fca40f20efeb966::derpy {
    struct DERPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPY>(arg0, 6, b"DERPY", b"Derpy", b"Only Derps allowed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_8ec0687fe9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

