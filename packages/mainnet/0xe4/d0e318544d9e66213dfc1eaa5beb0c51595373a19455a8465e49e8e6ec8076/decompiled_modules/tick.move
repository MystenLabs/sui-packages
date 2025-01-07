module 0xe4d0e318544d9e66213dfc1eaa5beb0c51595373a19455a8465e49e8e6ec8076::tick {
    struct TICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICK>(arg0, 6, b"Tick", b"tick token", x"616c6c20746865206b6f6c73206861766520626c7565207469636b0a62756c6c69736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1131728830790_pic_b6537187e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

