module 0x2ddf1a93dff3b0ee67164f571fe2e7e3872ea64b0bc954269da8cbd2df0fa87::flepe {
    struct FLEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEPE>(arg0, 6, b"FLEPE", b"Flipper Pepe", b"A salute to Matt Furie for creating Flipper Pepe, the oceanic cousin of iconic Pepe the Frog. Flipper Pepe explores the depths of our emotions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030730_8fb0e830ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

