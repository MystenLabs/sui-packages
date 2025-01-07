module 0xb89e2d468d77ae8cb265f4e13bdcd919bc6be849dffb49e4eb11f2b3f0970681::mpmp {
    struct MPMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MPMP>(arg0, 13950676199313194767, b"memepepe", b"mpmp", b"gibrid", b"https://images.hop.ag/ipfs/QmdCBZHLqLLBEtvJAnHUdptwiSQ7UNRghtni4nAC2EZdjG", 0x1::string::utf8(b"https://x.com/RudeWav"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

