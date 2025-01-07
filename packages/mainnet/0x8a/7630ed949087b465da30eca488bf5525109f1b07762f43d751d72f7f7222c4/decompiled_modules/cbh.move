module 0x8a7630ed949087b465da30eca488bf5525109f1b07762f43d751d72f7f7222c4::cbh {
    struct CBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBH>(arg0, 6, b"CBH", b"Cat birthday hat", b"No social send it, Why does a cat's face look gloomy when wearing a birthday hat, does anyone know?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000261101_57ab2fc110.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

