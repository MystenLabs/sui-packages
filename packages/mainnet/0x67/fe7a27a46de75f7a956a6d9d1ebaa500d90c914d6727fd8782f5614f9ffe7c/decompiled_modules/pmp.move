module 0x67fe7a27a46de75f7a956a6d9d1ebaa500d90c914d6727fd8782f5614f9ffe7c::pmp {
    struct PMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMP>(arg0, 6, b"PMP", b"Pump", b"No socials, No Bullshit, just $PMP SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_pump_picture_bicycle_flat_style_icon_42131096_50bb6e2f21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

