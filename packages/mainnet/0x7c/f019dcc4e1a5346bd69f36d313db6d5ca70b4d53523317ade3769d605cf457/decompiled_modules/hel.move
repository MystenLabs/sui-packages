module 0x7cf019dcc4e1a5346bd69f36d313db6d5ca70b4d53523317ade3769d605cf457::hel {
    struct HEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEL>(arg0, 6, b"Hel", b"Hello", b"jis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8530682_d1021160a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

