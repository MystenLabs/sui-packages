module 0xdd7ad7b66ed29685471e39f76ea49015c5c1feb55f4cb8fbc3b9c2e81e9801e4::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SUIYAN>(arg0, 3887009111023862579, b"Super Suiyan", b"SUIYAN", b"It's the Super Suiyan cycle", b"https://images.hop.ag/ipfs/QmbnM9L7FdGNLYgNpA6kmJw3sSf4QFRm36QEaqwmzk5Zn8", 0x1::string::utf8(b"https://x.com/supersuiyan"), 0x1::string::utf8(b"https://suiyancoin.com/"), 0x1::string::utf8(b"https://t.me/SUPERSUIYAN"), arg1);
    }

    // decompiled from Move bytecode v6
}

