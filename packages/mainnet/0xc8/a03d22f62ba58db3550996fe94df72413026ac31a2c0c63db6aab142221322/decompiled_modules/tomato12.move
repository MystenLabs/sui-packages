module 0xc8a03d22f62ba58db3550996fe94df72413026ac31a2c0c63db6aab142221322::tomato12 {
    struct TOMATO12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMATO12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMATO12>(arg0, 9, b"TOMATO12", b"TOMATO", x"0a456e746572696e6720746865206c6576656c2073797374656d206d65616e7320796f75e28099726520696e20666f72207468652061697264726f70e2809462652070726f756420696620796f75e280997665206d616465206974210a0a5468697320666561747572652077696c6c206265206c61756e6368696e6720696e206c657373207468616e20323420686f7572732c2062652072656164792e0a0a53686f772074686520776f726c6420796f757220f09f8d850a0a5477697474657220706f73743a2068747470733a2f2f782e636f6d2f546f6d61726b65744661726d65722f7374617475732f31383330363337393933383437333738323131", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f294b11-d51f-429f-bc3e-55aef46ebcd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMATO12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMATO12>>(v1);
    }

    // decompiled from Move bytecode v6
}

