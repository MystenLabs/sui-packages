module 0xf35ef74d98e181946b275c28fe2aa7a93c8afca0e520f45538d5a273eef468de::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 6, b"HAPPY", b"HAPPY", x"5374657020696e746f20746865204675747572652077697468204861707079e2809973204d656d6520436f696e20576562203320526577617264732c2047616d696e672c20616e64204e4654204d797374657269657320417761697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXF6bpU6CdL8BFKY9XnCX8x6tqJNWrsRSnbgNN1wZuAx7")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HAPPY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HAPPY>(9472139510772148099, v0, v1, 0x1::string::utf8(b"https://x.com/happy_on_sui?s=21"), 0x1::string::utf8(b"https://happycryptoinvestor.online/"), 0x1::string::utf8(b"https://t.me/happycointothemoon"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

