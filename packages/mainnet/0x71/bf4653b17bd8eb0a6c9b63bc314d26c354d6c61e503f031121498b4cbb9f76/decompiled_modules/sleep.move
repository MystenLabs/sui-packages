module 0x71bf4653b17bd8eb0a6c9b63bc314d26c354d6c61e503f031121498b4cbb9f76::sleep {
    struct SLEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SLEEP>(arg0, 5046943668820291178, b"Sleep and Dream", b"SLEEP", b"Have a nice dream on sui.  Start talking in your sleep at https://t.me/+oD0k1ikR3igxNzJl", b"https://images.hop.ag/ipfs/QmdmLn8bZWgif5aKZn49LUpBMJr49u9EnTVteS7otWdGh1", 0x1::string::utf8(b"https://x.com/zhanzhixiang1"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+oD0k1ikR3igxNzJl"), arg1);
    }

    // decompiled from Move bytecode v6
}

