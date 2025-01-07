module 0xcec36fb7824249aba0ee5f99f4bbfc3375d3b4aad155e58b5a2282fd6b83a44f::piger {
    struct PIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGER>(arg0, 6, b"PIGER", b"Piggy potter", b"Swinecraft and Hogswine-ry await!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054236_f4b1b5f0cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

