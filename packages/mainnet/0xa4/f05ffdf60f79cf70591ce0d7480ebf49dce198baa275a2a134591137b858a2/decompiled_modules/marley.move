module 0xa4f05ffdf60f79cf70591ce0d7480ebf49dce198baa275a2a134591137b858a2::marley {
    struct MARLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARLEY>(arg0, 6, b"MARLEY", b"The Painting Penguin", b"Marley, The Painting Penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_153412_968_a1325052bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

