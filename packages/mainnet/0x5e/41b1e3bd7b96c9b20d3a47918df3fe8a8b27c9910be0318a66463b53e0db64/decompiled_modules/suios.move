module 0x5e41b1e3bd7b96c9b20d3a47918df3fe8a8b27c9910be0318a66463b53e0db64::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 6, b"SUIOS", b"SUI looking good here", b"SUI GCR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2063_57341082c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

