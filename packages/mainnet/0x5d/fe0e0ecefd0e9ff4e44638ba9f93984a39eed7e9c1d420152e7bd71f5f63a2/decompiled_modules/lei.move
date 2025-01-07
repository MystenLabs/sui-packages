module 0x5dfe0e0ecefd0e9ff4e44638ba9f93984a39eed7e9c1d420152e7bd71f5f63a2::lei {
    struct LEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LEI>(arg0, 11592723539452222184, b"Leila", b"LEI", b"Bang, bang, money for Leila. Are you coming back to the world again?", b"https://images.hop.ag/ipfs/QmUXxBBzsWJhKgMU4Pss7hVvaRoBsa5ag3xdjsSUkri7BF", 0x1::string::utf8(b"https://x.com/bellydance0920?s=09"), 0x1::string::utf8(b"https://linktr.ee/bellyLeila"), 0x1::string::utf8(b"https://t.me/+WTW9dMydOtBiNWQ0"), arg1);
    }

    // decompiled from Move bytecode v6
}

