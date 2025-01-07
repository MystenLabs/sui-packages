module 0x42ca2c72c8cfdd5e50c1ba31319593e48f3bd0e379142d093b12531caa96c938::turtle {
    struct TURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLE>(arg0, 6, b"Turtle", b"Sui Turtle", b"Sea Sui Turtle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_213048_519b7b524d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

