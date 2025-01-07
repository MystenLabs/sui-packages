module 0x9e5559459ff6b99974d70fb95c7f4f405b02f3c761f69035263b760d0150b02e::f13 {
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

