module 0x4f3f6840a916ace61443468d1d64574842c0be493065e7d14b6883594dfe3409::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Moonlite", b"Sui trading at its full potential | High speeds  Low fees | Currently in Private Beta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOON_d66e6ffb69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

