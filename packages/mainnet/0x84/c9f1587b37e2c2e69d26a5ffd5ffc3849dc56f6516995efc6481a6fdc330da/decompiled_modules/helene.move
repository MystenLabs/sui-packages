module 0x84c9f1587b37e2c2e69d26a5ffd5ffc3849dc56f6516995efc6481a6fdc330da::helene {
    struct HELENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELENE>(arg0, 6, b"Helene", b"Helene cat4", b"A CAT4 hurricane community driven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013585_7d2031c258.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

