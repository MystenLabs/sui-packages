module 0x54701c7d53fdaadbba126a83ec90a099b16ad53161c7b26ffd5ddcc3c9b415f5::cosmic {
    struct COSMIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMIC>(arg0, 6, b"COSMIC", b"Cosmic", b"Due to increased volume we are launching $COSMIC on SUI making our token multichain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cosmic_Logo_390b8a4dee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSMIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

