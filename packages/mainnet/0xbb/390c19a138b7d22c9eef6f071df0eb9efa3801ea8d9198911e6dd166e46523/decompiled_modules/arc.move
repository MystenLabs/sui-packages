module 0xbb390c19a138b7d22c9eef6f071df0eb9efa3801ea8d9198911e6dd166e46523::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 6, b"ARC", b"ARC-AGI", b"        ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/arcagi_33b23a2a8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

