module 0xa9b7ebbc798ba6a786148cb4b7dfdab8cafca7f0b787fe279a2577607a339383::bworld {
    struct BWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWORLD>(arg0, 6, b"BWORLD", b"BLUE WORLD", b"Let's feel the world with SUI and make it blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/depositphotos_535243394_stock_illustration_didital_planet_earth_blue_hologram_d50bf8b2da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

