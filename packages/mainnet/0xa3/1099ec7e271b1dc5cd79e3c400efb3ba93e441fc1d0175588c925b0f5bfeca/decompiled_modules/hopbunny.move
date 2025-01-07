module 0xa31099ec7e271b1dc5cd79e3c400efb3ba93e441fc1d0175588c925b0f5bfeca::hopbunny {
    struct HOPBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPBUNNY>(arg0, 14335060523537396252, b"Hop Bunny", b"HopBunny", b"HOP BUNNY THE FIRST BUNNY ON @hopaggregator& @suinetwork. Coming soon on http://hop.fun", b"https://images.hop.ag/ipfs/QmbkLAsbAgonB67EgvfWjLD4RPzyW8WZM9Jjn5qArwjQe5", 0x1::string::utf8(b"https://x.com/HopBunnyonsui"), 0x1::string::utf8(b"https://www.hopbunny.fun/"), 0x1::string::utf8(b"https://t.me/HopBunnyonSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

