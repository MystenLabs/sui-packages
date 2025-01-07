module 0xa1dab76ba1c86196a9a146ac4daf05cf7137414a7980749c91d6c5eac465c3ae::puppies18 {
    struct PUPPIES18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPIES18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPIES18>(arg0, 6, b"Puppies18", b"Puppies", b"Puppies lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022040_3e50063012.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPIES18>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPIES18>>(v1);
    }

    // decompiled from Move bytecode v6
}

