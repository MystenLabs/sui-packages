module 0x6b71b6cc714704d20d562700cc2c15bfcf5af363a19ca57215046559b486996e::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<MIGO>(arg0, 496746828607502073, b"Amigos", b"Migo", b"The meme coin that's so laid-back, it's practically horizontal.", b"https://images.hop.ag/ipfs/QmbX9NveFjtYhDuetVw1RAXQbQAMHpB7W5ygZ1RTTjYHed", 0x1::string::utf8(b"https://x.com/Amigosmemecoin"), 0x1::string::utf8(b"https://amigosofficial.com"), 0x1::string::utf8(b"https://t.me/+XPBjZLILtokwMWFh"), arg1);
    }

    // decompiled from Move bytecode v6
}

