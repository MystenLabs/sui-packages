module 0xc123c1b12da129e699b8c0915ddd2d4f52405bc932697423b744f19b23de49fe::donte {
    struct DONTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTE>(arg0, 6, b"Donte", b"hyper", b"Dont", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whitepaper_9d94c9ceaa.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

