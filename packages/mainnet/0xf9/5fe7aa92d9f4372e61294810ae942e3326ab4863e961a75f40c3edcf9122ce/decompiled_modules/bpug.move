module 0xf95fe7aa92d9f4372e61294810ae942e3326ab4863e961a75f40c3edcf9122ce::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BPUG>(arg0, 8286924812188326304, b"Baby Pug", b"BPUG", b"FUD's baby", b"https://images.hop.ag/ipfs/QmPB1UwNbUYq9vCmZRufRPNVEKKXeCKSMLiXpwbFoWWxur", 0x1::string::utf8(b"https://x.com/babypugonsui"), 0x1::string::utf8(b"https://thebabypug.com"), 0x1::string::utf8(b"https://t.me/babypugonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

