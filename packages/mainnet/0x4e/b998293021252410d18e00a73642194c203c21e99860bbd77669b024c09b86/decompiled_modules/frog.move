module 0x4eb998293021252410d18e00a73642194c203c21e99860bbd77669b024c09b86::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FROG>(arg0, 12614351956395969607, b"HopFrog", b"FROG", b"From the ashes, a new community rose: not just a Frog, but a more grounded, united Shinobi Dojo.", b"https://images.hop.ag/ipfs/Qma5ZKgsTL9eMLukK65UkPzZjjUn7MLWM3HChhKuFNtD1c", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

