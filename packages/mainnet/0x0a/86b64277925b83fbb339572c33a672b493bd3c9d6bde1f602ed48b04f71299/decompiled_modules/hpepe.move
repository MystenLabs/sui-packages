module 0xa86b64277925b83fbb339572c33a672b493bd3c9d6bde1f602ed48b04f71299::hpepe {
    struct HPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPEPE>(arg0, 6, b"HPEPE", b"HopPEPE", b"PEPE IS COMING IN DA HOUSE. READY TO RUMBLE?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZMTnCNYincJTTtNvxptHGEnB36F336C544Re5Zjo2QLj")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HPEPE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HPEPE>(280770176689751659, v0, v1, 0x1::string::utf8(b"https://x.com/Hopfunpepe"), 0x1::string::utf8(b"https://hoppepe.online"), 0x1::string::utf8(b"htpps://t.me/Hopfunpepe"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

