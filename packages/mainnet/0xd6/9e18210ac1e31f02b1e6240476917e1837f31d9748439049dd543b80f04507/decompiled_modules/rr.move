module 0xd69e18210ac1e31f02b1e6240476917e1837f31d9748439049dd543b80f04507::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 6, b"RR", b"Rasta Rat", b"Just a rat and his spliff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7020_2243fe8115.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RR>>(v1);
    }

    // decompiled from Move bytecode v6
}

