module 0x760add697c98e6e89d72904fa1b123bd6b30efdb509acbd26d1c67068f3063c8::suiikawa {
    struct SUIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIKAWA>(arg0, 6, b"SUIIKAWA", b"Suiikawa", b"Kawaii creatures in the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1406_2e20422eb9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

