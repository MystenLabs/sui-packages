module 0x213649451d0ba0ab4de23ad85f5d88086e4bd342e188fa1ab9b52eaeb2685b3e::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 6, b"SPACEX", b"SPACE X", x"456c6f6e206d75736b2054776565742061626f7574206f75722073706163652078200a4c657473206675636b696e67206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052996_d2e8954d7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

