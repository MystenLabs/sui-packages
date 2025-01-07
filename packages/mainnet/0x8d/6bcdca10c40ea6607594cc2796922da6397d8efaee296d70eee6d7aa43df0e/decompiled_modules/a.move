module 0x8d6bcdca10c40ea6607594cc2796922da6397d8efaee296d70eee6d7aa43df0e::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"AMEM", b"A AND NOTHING ELSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A1_357512385f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

