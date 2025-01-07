module 0xa352ba95d988cb4e81a611ee72140f0d9b9856bc5188875cc958c23d2083e4bd::bgt {
    struct BGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGT>(arg0, 6, b"BGT", b"BLUE GOAT", b"CUTE GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_b9c2d2461a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

