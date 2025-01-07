module 0x71f5a1b212bea2648cf4cf1c55195b4a631e9f0135aa88fcc7953aa2252c6087::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"Sad Crypto Investor", b"Wen pamp? Wen altseason? Wen rich ser? T_T", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116110_4802e28092.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

