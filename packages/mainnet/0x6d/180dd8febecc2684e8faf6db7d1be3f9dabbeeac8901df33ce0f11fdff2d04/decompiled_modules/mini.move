module 0x6d180dd8febecc2684e8faf6db7d1be3f9dabbeeac8901df33ce0f11fdff2d04::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"Mini", b"mini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/minimal_f9957a6a0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

