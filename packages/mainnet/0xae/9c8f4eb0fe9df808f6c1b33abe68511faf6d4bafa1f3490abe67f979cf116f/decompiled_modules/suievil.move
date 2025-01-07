module 0xae9c8f4eb0fe9df808f6c1b33abe68511faf6d4bafa1f3490abe67f979cf116f::suievil {
    struct SUIEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEVIL>(arg0, 6, b"SUIevil", b"Terminal Of Lies", x"4f6e6c792074726f75676820244576696c20776179732c2067726561746e6573732063616e2062652061636869657665642e0a0a58203a2068747470733a2f2f782e636f6d2f5465726d696e616c4f664c6965730a54656c656772616d3a2068747470733a2f2f742e6d652f7465726d696e616c6f666c6965736576696c0a57656273697465203a2068747470733a2f2f6c69657465726d696e616c2e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_153707_202_5fc87c61ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

