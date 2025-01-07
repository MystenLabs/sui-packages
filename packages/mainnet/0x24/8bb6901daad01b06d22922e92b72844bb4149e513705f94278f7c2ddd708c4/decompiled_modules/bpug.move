module 0x248bb6901daad01b06d22922e92b72844bb4149e513705f94278f7c2ddd708c4::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BPUG>(arg0, 2291800170838128688, b"Baby Pug", b"BPUG", b"Fud the Pug's baby", b"https://images.hop.ag/ipfs/QmPB1UwNbUYq9vCmZRufRPNVEKKXeCKSMLiXpwbFoWWxur", 0x1::string::utf8(b"https://x.com/babypugonsui"), 0x1::string::utf8(b"https://thebabypug.com"), 0x1::string::utf8(b"https://t.me/babypugonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

