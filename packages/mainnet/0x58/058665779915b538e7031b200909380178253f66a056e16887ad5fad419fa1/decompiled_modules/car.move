module 0x58058665779915b538e7031b200909380178253f66a056e16887ad5fad419fa1::car {
    struct CAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CAR>(arg0, 3377816162472798575, b"Cat and Rat", b"CAR", b"despite being enemies naturally , they are friends for life in Sui ecosystem.", b"https://images.hop.ag/ipfs/QmRdQzmnYnk41FLHd4xW8XhYhpJRtNQHZpUYsb5Yf44xTE", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

