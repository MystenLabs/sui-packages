module 0xc78db64419fafa1af7df07709ba15f925c47461332cb0bd66743ce5d52b743f3::tomlee {
    struct TOMLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMLEE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TOMLEE>(arg0, 2934005378160679042, b"Tom Lee was right", b"tomlee", b"for the believers", b"https://images.hop.ag/ipfs/Qmf7f2ei52yiuBWZt4A5bWi8Kr2SyuzuWD39GK3ZQ8L9jw", 0x1::string::utf8(b"https://x.com/fundstrat"), 0x1::string::utf8(b"https://fsinsight.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

