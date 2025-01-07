module 0xae24d3a063d190e94522a77556b99f72de19eebbb46d6067d7a0d4e7b382c589::ahol {
    struct AHOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AHOL>(arg0, 6, b"AHOL", b"AHole by SuiAI", b"'AHole' AI was conceptualized by a group of bio-technologists and economists who wanted to highlight the often overlooked yet crucial aspects of systems, both biological and economic. They chose the butthole as a metaphor for something essential yet often ignored or underappreciated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2_e19dad243b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AHOL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHOL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

