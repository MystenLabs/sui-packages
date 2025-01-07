module 0x9eb178ab310097794a7c0bd7f083d602b476d8d883a811bcee1ec6ff31c7badd::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 11195829716561854587, b"Hopfrog", b"HOPFROG", b"Hopfrog", b"https://images.hop.ag/ipfs/QmZggTzfYy5efyiXam8AZwgiPtTDpwF6pdLGxFV64UnafJ", 0x1::string::utf8(b"https://x.com/hopfrogsui?s=21"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

