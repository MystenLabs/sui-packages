module 0xaeb2a00547a81a256fd1a734d2adf8918b5e7f4321f5d48210fbcef9a22abb12::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOG>(arg0, 11086429927879262349, b"Hop Dog", b"HOPDOG", b"$HOPDOG, Sui's and Hop's best dog!", b"https://images.hop.ag/ipfs/QmRKatJ6xRmwJ3NaK24UT4WwU7YqCXTWQbTf4AZGnHPn8R", 0x1::string::utf8(b"https://x.com/hopdog_sui"), 0x1::string::utf8(b"https://hopdogsui.fun/"), 0x1::string::utf8(b"https://t.me/hopdogsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

