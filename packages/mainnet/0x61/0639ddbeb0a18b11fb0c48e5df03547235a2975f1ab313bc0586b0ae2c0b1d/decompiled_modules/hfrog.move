module 0x610639ddbeb0a18b11fb0c48e5df03547235a2975f1ab313bc0586b0ae2c0b1d::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HFROG>(arg0, 13407395623062075751, b"HopFrog", b"HFROG", b"HOP THE FROG! Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.", b"https://images.hop.ag/ipfs/QmcXZ55292AinejS6BLajBZRumbUY5kQg7xKC3B9EmGA6Y", 0x1::string::utf8(b"https://x.com/hopfrogsui"), 0x1::string::utf8(b"https://hopfrog.fun"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

