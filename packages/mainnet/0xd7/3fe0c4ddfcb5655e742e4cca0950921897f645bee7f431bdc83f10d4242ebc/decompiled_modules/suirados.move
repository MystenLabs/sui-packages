module 0xd73fe0c4ddfcb5655e742e4cca0950921897f645bee7f431bdc83f10d4242ebc::suirados {
    struct SUIRADOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRADOS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIRADOS>(arg0, 8826254699381438183, b"Suirados", b"SUIRADOS", b"Suirados is known to be extremely violent, often flying into an outrage and destroying all the red candles and jeets. Don't stay being a Magikarp, become a Suirados!", b"https://images.hop.ag/ipfs/QmapCteVv6ganzMTAfyvzBGYuCKBj5uktw3p9MzdUUQtvA", 0x1::string::utf8(b"https://x.com/"), 0x1::string::utf8(b"https://deving.suraidos"), 0x1::string::utf8(b"https://t.me/suirados"), arg1);
    }

    // decompiled from Move bytecode v6
}

