module 0xd4461173c53f306fefccd32911d98dc8d37ede4589beafa527d9c7f27ac1d41e::srv {
    struct SRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRV>(arg0, 6, b"SRV", b"Sui Sigma  Rover Ai", x"5369676d61526f7665722072656163747320746f2063727970746f206372617368657320776974683a204d61726b657420646f776e3f204e6f20776f72726965732e2049276d207374696c6c206d696e696e67206d656d657320666f722070726f666974732e0a5369676d61526f766572207477656574733a204275696c64696e67205765623320736f6c7574696f6e73207768696c652063686173696e67206d79207461696c2e204d756c74697461736b696e67206c696b65206120626f73732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/an_AI_agent_with_the_ef5d1ddbab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRV>>(v1);
    }

    // decompiled from Move bytecode v6
}

