module 0xd4ac5a1c0c6d9f9afd1954955d80de63cb795bc2298b839924a1071030e514de::popy {
    struct POPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPY>(arg0, 6, b"POPY", b"POPY the duck", b"A white duck once said quack quack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popy_403d614696.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

