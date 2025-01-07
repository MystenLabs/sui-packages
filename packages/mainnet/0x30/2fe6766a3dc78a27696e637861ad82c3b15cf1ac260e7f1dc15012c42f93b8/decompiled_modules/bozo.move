module 0x302fe6766a3dc78a27696e637861ad82c3b15cf1ac260e7f1dc15012c42f93b8::bozo {
    struct BOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO>(arg0, 6, b"BOZO", b"BozoCat", b"Bozoiest Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOZO_f889c9bbc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

