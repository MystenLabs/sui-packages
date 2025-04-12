module 0x6342988052394f6dff78a512374ad3757cc2d778ffc37d1c32a4d36f712f6f4f::tariffs {
    struct TARIFFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARIFFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARIFFS>(arg0, 6, b"TARIFFS", b"Tariff Pump", b"The tariff increase initiated by Donald Trump has triggered a trade war with various countries, many countries have contacted Trump as if \"I am ready to lick your ass\" to negotiate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056820_16c3105161.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARIFFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARIFFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

