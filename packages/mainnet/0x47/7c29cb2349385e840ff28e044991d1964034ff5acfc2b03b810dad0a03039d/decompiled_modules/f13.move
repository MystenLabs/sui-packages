module 0x477c29cb2349385e840ff28e044991d1964034ff5acfc2b03b810dad0a03039d::f13 {
    struct F13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F13>(arg0, 6, b"F13", b"Friday 13th", b"Be careful on this day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/112337_90f013a9d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F13>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F13>>(v1);
    }

    // decompiled from Move bytecode v6
}

