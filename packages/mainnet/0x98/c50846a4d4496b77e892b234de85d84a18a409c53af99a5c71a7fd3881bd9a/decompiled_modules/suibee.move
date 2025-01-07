module 0x98c50846a4d4496b77e892b234de85d84a18a409c53af99a5c71a7fd3881bd9a::suibee {
    struct SUIBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIBEE>(arg0, 10959996477318014759, b"SUI BEE", b"SUIBEE", b"Apooh has come out of hibernation and is on the hunt for all the SUIBEE he can find in the Hundred Million Mcap Wood.", b"https://images.hop.ag/ipfs/QmWXwxpaWYeHwPxTJv82HpN1mJZqDVE2bp2is8PwXtNC8F", 0x1::string::utf8(b"https://x.com/beeonsuiii"), 0x1::string::utf8(b"https://www.subee.fun/"), 0x1::string::utf8(b"https://t.me/sui_bee"), arg1);
    }

    // decompiled from Move bytecode v6
}

