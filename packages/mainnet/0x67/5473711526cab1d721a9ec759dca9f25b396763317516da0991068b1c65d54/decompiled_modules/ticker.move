module 0x675473711526cab1d721a9ec759dca9f25b396763317516da0991068b1c65d54::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        0xdec18f0fd6e894039fd24a8519d89427ce3912a382d6454949c9d3c4d9c36f01::connector_v3::new<TICKER>(arg0, 626706816, b"TICKER", b"ticker", b"Ticker token", b"https://ipfs.io/ipfs/bafkreief2yhdjb55o2hmol5bsdzjjvyy4oxd7saotppmbmsxe5ptnbrxau", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

