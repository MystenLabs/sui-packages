module 0xba5030df8a6b79e3966e79a8d3197ce007443a69721538d2f3940f20fe2c99d2::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORM>(arg0, 6, b"WORM", b"WORM SUI", x"24574f524d5320697320696e7370697265642062792074686520766964656f2067616d6520576f726d732c2024574f524d53206861732061206d697373696f6e20746f2070726f746563742074686520656e7669726f6e6d656e742e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ca710634f81b2f209915540e4df1497b_9ad596ac79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

