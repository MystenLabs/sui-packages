module 0xa60a187d73c17bac5dc45393ed558ef36d6551a4ad11f617c29bad15927067a3::hopp {
    struct HOPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPP>(arg0, 12381116851427167823, b"Hop Bunny", b"HOPP", b"One sunny day, he discovered a hidden path that led to a sparkling stream, where he met a wise old turtle who shared stories of adventure and friendship. From that day on, Bunny learned the importance of curiosity and the joy of making new friends in his beautiful world, and also bunny decided to create a coin for his new friends so they can be unique in the jungle. From that day on bunny and his friends that had the coin were living in their own world field and could make their wish come through with a single $HOPP coin", b"https://images.hop.ag/ipfs/QmZ2qx6GyeUtvNrsfu6bLMCq8FVGuSGgKYt2CtXPhDohqq", 0x1::string::utf8(b"https://x.com/HopBunnyonsui"), 0x1::string::utf8(b"https://www.hopbunny.fun/"), 0x1::string::utf8(b"https://t.me/HopBunnyonSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

