module 0x886d19633996f0fb58b76846068ff1a74d7e36a648a22c22a03eae05e238d4db::suisqd {
    struct SUISQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISQD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SUISQD>(arg0, 14948120753317845896, b"SuiSquid", b"SuiSQD", b"A squid that will rise on the shoulders of the community. Together we are strong", b"https://images.hop.ag/ipfs/QmZPjqKEGcN1pyGjAa1eh95LJyK7VnGVk8vGk934cTnp3M", 0x1::string::utf8(b"https://x.com/squid_tg"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

