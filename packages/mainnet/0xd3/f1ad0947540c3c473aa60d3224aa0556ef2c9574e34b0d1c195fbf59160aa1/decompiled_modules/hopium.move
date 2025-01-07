module 0xd3f1ad0947540c3c473aa60d3224aa0556ef2c9574e34b0d1c195fbf59160aa1::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"HOPIUM", b"HOPIUM", b"Once Upon a Meme-In a world where serious crypto projects ruled, a playful memecoin called $HOPIUM burst onto the scene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmREEmntmUqpDp8goDBjxXK5cvRiEvvnAYinj426Kes3ro")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPIUM>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPIUM>(16126699964326726909, v0, v1, 0x1::string::utf8(b"https://x.com/Hopiumsui"), 0x1::string::utf8(b"https://hopium.wtf/"), 0x1::string::utf8(b"https://t.me/hopiumsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

