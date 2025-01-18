module 0x78b511dd5ac878a4bd79ea819ea3e0e922e9a7eeb398a7c5ba6cbb49562e0789::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMP>(arg0, 17757974151478319457, b"$TRUMP", b"$TRUMP", x"4d79204e4557204f6666696369616c205472756d70204d656d65206973204845524521204974e28099732074696d6520746f2063656c6562726174652065766572797468696e67207765207374616e6420666f723a2057494e4e494e4721", b"https://images.hop.ag/ipfs/QmbYWz8RGwQDHEHiePctHhp3pGYBymrAuyQMfXCRcuVbV3", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://gettrumpmemes.com/"), 0x1::string::utf8(b"https://t.me/solthesecret"), arg1);
    }

    // decompiled from Move bytecode v6
}

