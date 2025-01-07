module 0x3e295b4b835496ee460a503d37f44e1696cc2d38d2c27484ae8ab542e3ce0fe1::hoprabbit {
    struct HOPRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPRABBIT>(arg0, 6, b"HopRabbit", b"HopRabbit", b"First rabbit on hopfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcjJPsYoytXCn1dmZDqXuCkv8rxn8N19iY7UGMQLsB7ya")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPRABBIT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPRABBIT>(6299904447677989943, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"https://tg.hop.ag/"), 0x1::string::utf8(b"https://t.me/+biKJEa8POMViNTM5"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

