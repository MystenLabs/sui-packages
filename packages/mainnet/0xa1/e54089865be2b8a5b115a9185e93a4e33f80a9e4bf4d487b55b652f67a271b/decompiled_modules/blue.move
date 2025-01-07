module 0xa1e54089865be2b8a5b115a9185e93a4e33f80a9e4bf4d487b55b652f67a271b::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLUE>(arg0, 13544718459216701884, b"I'm Blue", b"Blue", b"Just be Blue", b"https://images.hop.ag/ipfs/QmdRMSMDQ9pM21bwiN6c1NA4mP3oYxZ2ayz2B5KFJBUwHn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/imblueasui"), arg1);
    }

    // decompiled from Move bytecode v6
}

