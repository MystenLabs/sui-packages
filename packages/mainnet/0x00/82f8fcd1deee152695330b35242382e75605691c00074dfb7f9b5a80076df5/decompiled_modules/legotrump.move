module 0x82f8fcd1deee152695330b35242382e75605691c00074dfb7f9b5a80076df5::legotrump {
    struct LEGOTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOTRUMP>(arg0, 6, b"LEGOTRUMP", b"Lego Trump", x"4d656574204c45474f5452554d502c20546865206f6e6c7920636f696e207768657265205472756d70206275696c647320686973206f776e2077616c6c2c206f6e6520627269636b20617420612074696d652e204e6f20696e737472756374696f6e73206e6565646564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_6c84b8baf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

