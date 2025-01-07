module 0x801e90310e084ac19b1dfb88be5c0e68598d83473330cec3415807a11b0ee094::wtd {
    struct WTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTD>(arg0, 6, b"WTD", b"Ducks", b"If it looks like a duck, swims like a duck, and quacks like a duck, then it probably is a duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUCK_6688fd36a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

