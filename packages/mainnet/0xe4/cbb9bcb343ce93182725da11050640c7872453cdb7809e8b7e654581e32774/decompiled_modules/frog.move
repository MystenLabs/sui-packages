module 0xe4cbb9bcb343ce93182725da11050640c7872453cdb7809e8b7e654581e32774::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FROG>(arg0, 16386578005521720280, b"HopFrog", b"FROG", b"From the ashes, a new community rose: not just a Frog, but a more grounded, united Shinobi Dojo.", b"https://images.hop.ag/ipfs/QmbfVpy2htvFvc3riGfVGwoL66i7D9JJcR4hc6G6UYbzV6", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

