module 0xc3eeb78dc1d161fe6c8b9018208374f9959d653e1e06f72f7395e3cb165dac73::f420690000000 {
    struct F420690000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F420690000000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F420690000000>(arg0, 6, b"F420690000000", b"FIGHT", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8311_a45208977f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F420690000000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F420690000000>>(v1);
    }

    // decompiled from Move bytecode v6
}

