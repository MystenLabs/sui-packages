module 0xde96f5a4aac5b56f72d26b72c10bfba9b7e5591d512371f3607dd69e1c720ae1::rally {
    struct RALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RALLY>(arg0, 6, b"RALLY", b"RALLY DOG", b"Rally dog: Go Giants!!! #SFGiants", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_23_29_24_c8bc0e566b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

