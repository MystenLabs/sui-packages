module 0x82f26fa81bd769e45f9d4a17a2ad7cbea4ed137d8b5dbe682ed0b4cbbc67aec4::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOG>(arg0, 16638012264094361927, b"HopDog", b"$HOPDOG", b"$HOPDOG, Sui's and Hop's best dog!", b"https://images.hop.ag/ipfs/QmRKatJ6xRmwJ3NaK24UT4WwU7YqCXTWQbTf4AZGnHPn8R", 0x1::string::utf8(b"https://x.com/hopdog_sui"), 0x1::string::utf8(b"https://hopdogsui.fun/"), 0x1::string::utf8(b"https://t.me/hopdogsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

