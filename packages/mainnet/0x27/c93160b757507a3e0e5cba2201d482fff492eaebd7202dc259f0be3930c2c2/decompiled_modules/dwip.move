module 0x27c93160b757507a3e0e5cba2201d482fff492eaebd7202dc259f0be3930c2c2::dwip {
    struct DWIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIP>(arg0, 6, b"DWIP", b"DWIP SUI", b"Lil Dwip, Bwig flows.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/happy_raindrop_by_roseycheekes_d26inrw_375w_2x_b6b62f3bb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

