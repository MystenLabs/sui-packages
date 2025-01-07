module 0x8f1db6f1100f09b22cbfb16c58de7c85a202426e8b13698022423a0cb543b36b::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"Sea", b"Seahorse", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010475_e5f6b8fb6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

