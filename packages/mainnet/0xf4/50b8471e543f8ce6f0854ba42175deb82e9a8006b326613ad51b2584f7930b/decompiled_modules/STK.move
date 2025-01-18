module 0xf450b8471e543f8ce6f0854ba42175deb82e9a8006b326613ad51b2584f7930b::STK {
    struct STK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STK>(arg0, 6, b"X", b"X", b"X token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://de.fi/test.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

