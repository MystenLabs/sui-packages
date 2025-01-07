module 0xa04eac07367aee58fa84e4703f90d9848d8ec4a3b561ceecfd94e1d76426148::turtle {
    struct TURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLE>(arg0, 6, b"Turtle", b"Squirtle The Turtle", b"Squirtle.Squirtle .Squirtle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_4_79dfb95e05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

