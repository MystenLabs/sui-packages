module 0xf7e88e429512eb3595c1eb634896a0d668d76ca99cec33ed2f4d7adf48ae76fc::lei {
    struct LEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LEI>(arg0, 984883715998022263, b"Lei", b"LEI", b"Bang, bang, money for Leila. Are you coming back to the world again?", b"https://images.hop.ag/ipfs/QmUXxBBzsWJhKgMU4Pss7hVvaRoBsa5ag3xdjsSUkri7BF", 0x1::string::utf8(b"https://x.com/bellydance0920?s=09"), 0x1::string::utf8(b"https://linktr.ee/bellyLeila"), 0x1::string::utf8(b"https://t.me/+WTW9dMydOtBiNWQ0"), arg1);
    }

    // decompiled from Move bytecode v6
}

