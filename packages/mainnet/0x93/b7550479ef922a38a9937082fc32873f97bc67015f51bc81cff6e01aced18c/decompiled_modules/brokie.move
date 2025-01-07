module 0x93b7550479ef922a38a9937082fc32873f97bc67015f51bc81cff6e01aced18c::brokie {
    struct BROKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKIE>(arg0, 6, b"BROKIE", b"Brokie On Sui", b"\"I used to be broke, but now im Brokie - Mr. Brokie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_591223540b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

