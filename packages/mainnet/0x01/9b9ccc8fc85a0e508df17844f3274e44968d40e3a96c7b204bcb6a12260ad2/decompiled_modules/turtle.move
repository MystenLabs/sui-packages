module 0x19b9ccc8fc85a0e508df17844f3274e44968d40e3a96c7b204bcb6a12260ad2::turtle {
    struct TURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLE>(arg0, 6, b"TURTLE", b"SuiSQUIRTLE", b"$TURTLE - Squirtle, Cutest turle on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_080824_3b20964968.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

