module 0xcc6ffe59a96324ab36750ded86b74680cd5811b6256f2dc5991f8494ed6fa176::cbag {
    struct CBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBAG>(arg0, 6, b"CBAG", b"catinbluebag", b"Just a cat in a blue bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwifbluebag_fbd6534225.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

