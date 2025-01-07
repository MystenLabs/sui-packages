module 0x39026e8b75e1c47b9b2d24f545f75b13e9464296038014a01c24125e5b920c98::sgecko {
    struct SGECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGECKO>(arg0, 6, b"SGECKO", b"Sui Gecko", x"546865206f6666696369616c20746f6b656e206f6620746865204765636b6f2065636f73797374656d0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_GECKO_6ce781d90a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

