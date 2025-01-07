module 0x5013673da0a9cc84e80da1962b9a24f98538d93c8cf64caea965fe6ff061d2e2::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPPY>(arg0, 16792909026417690670, b"HOPPY", b"Hoppy", b"An immortal jayful rabbit bringing SUI szn back on track.", b"https://images.hop.ag/ipfs/QmeG247AAEcBMQABtNb3WbuPEKySfora3b1vKaaA8Cf5TF", 0x1::string::utf8(b"https://x.com/HoppyOnSui_X"), 0x1::string::utf8(b"https://hoppyonsui.xyz/"), 0x1::string::utf8(b"https://t.me/Hoppyonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

