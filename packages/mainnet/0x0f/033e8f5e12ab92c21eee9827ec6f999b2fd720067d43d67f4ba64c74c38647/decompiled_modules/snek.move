module 0xf033e8f5e12ab92c21eee9827ec6f999b2fd720067d43d67f4ba64c74c38647::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"SNEK OFFICIAL", b"itsss my year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snek_21c5c6c2fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

