module 0xcb362dcd970b1c317503428c463af4a10738ca6940da83391d9f164b0df9d719::krillin {
    struct KRILLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRILLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRILLIN>(arg0, 6, b"KRILLIN", b"Krillin Dragon Ball", x"4b72696c6c696e20284a6170616e6573653a20e382afe383aae383aae383b32c204865706275726e3a204b75726972696e2920286b6e6f776e206173204b75726972696e20696e2046756e696d6174696f6e277320456e676c697368207375627469746c657320616e642056697a204d6564696127732072656c65617365206f6620746865206d616e676129", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.daosui.fun/uploads/krillin_2_892a9c70a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRILLIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRILLIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

