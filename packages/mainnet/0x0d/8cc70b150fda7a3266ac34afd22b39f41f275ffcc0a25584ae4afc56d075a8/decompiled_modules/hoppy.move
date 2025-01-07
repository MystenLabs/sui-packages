module 0xd8cc70b150fda7a3266ac34afd22b39f41f275ffcc0a25584ae4afc56d075a8::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPPY>(arg0, 2518061906044561904, b"HOPPY", b"HOPPY", b"Happy Hoppy Rabbit on #Suinetwork", b"https://images.hop.ag/ipfs/QmeG247AAEcBMQABtNb3WbuPEKySfora3b1vKaaA8Cf5TF", 0x1::string::utf8(b"https://x.com/HoppyOnSui_X"), 0x1::string::utf8(b"https://hoppyonsui.xyz/"), 0x1::string::utf8(b"https://t.me/Hoppyonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

