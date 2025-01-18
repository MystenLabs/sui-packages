module 0x4b3d20ac26e686635abc28960f516ad64ac7215338c8a8db37e4ef8a06cea033::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMP>(arg0, 629448485401663047, b"Official Trump", b"TRUMP", b"Make crypto great again", b"https://images.hop.ag/ipfs/QmfBA6smcgc74DZ2rYho2Pjqrh67q7wT7Nved7pbNWtnoQ", 0x1::string::utf8(b"https://x.com/realDonaldTrump?t=h5z9gDn8b1uDvcZrqSIIeQ&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

