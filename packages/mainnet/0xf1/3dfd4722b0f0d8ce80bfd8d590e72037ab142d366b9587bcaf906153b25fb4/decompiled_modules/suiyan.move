module 0xf13dfd4722b0f0d8ce80bfd8d590e72037ab142d366b9587bcaf906153b25fb4::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SUIYAN>(arg0, 14930389260612331593, b"Super Suiyan", b"SUIYAN", b"It's the Super Suiyan cycle", b"https://images.hop.ag/ipfs/QmbnM9L7FdGNLYgNpA6kmJw3sSf4QFRm36QEaqwmzk5Zn8", 0x1::string::utf8(b"https://x.com/supersuiyan"), 0x1::string::utf8(b"https://suiyancoin.com/"), 0x1::string::utf8(b"https://t.me/SUPERSUIYAN"), arg1);
    }

    // decompiled from Move bytecode v6
}

