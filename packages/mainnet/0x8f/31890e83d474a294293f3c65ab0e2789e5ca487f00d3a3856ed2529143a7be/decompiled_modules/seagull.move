module 0x8f31890e83d474a294293f3c65ab0e2789e5ca487f00d3a3856ed2529143a7be::seagull {
    struct SEAGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAGULL>(arg0, 6, b"Seagull", b"Seagull on a fucking Seagull", b"Seagull on a fucking Seagull. Whats more Degen than that. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_1502_2c3027e16a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

