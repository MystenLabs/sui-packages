module 0xa07c20636760736c9d5947b99fe6265730e7122de6777e476aa09da6d2c3cc7::suith {
    struct SUITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITH>(arg0, 6, b"SUITH", b"Suith Park", b"Friendly faces everwhere humble folks without temptation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiparkx_581ba4872c.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITH>>(v1);
    }

    // decompiled from Move bytecode v6
}

