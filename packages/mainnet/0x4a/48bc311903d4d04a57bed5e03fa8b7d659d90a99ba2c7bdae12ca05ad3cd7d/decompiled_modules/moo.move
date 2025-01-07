module 0x4a48bc311903d4d04a57bed5e03fa8b7d659d90a99ba2c7bdae12ca05ad3cd7d::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"Moo On sui", b"Get ready to milk memecoin hype with $MOO on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000527_2d5f4afa45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

