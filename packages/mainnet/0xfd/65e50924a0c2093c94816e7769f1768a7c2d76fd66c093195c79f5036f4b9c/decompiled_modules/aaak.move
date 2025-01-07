module 0xfd65e50924a0c2093c94816e7769f1768a7c2d76fd66c093195c79f5036f4b9c::aaak {
    struct AAAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAK>(arg0, 6, b"AAAK", b"aaa kitten", x"4141414141414141414141414141414141414141414141414141414141414141414141414143616e27742073746f702c20776f6e27742073746f70200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6729_3f39692e96_882d158f17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

