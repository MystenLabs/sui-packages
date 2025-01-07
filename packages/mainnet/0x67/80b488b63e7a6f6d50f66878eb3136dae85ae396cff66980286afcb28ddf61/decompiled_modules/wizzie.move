module 0x6780b488b63e7a6f6d50f66878eb3136dae85ae396cff66980286afcb28ddf61::wizzie {
    struct WIZZIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZZIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZZIE>(arg0, 6, b"WIZZIE", b"WIZZIESUI", b"WIZZIE ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/axd_D6x_N6_400x400_3f9220eebc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZZIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZZIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

