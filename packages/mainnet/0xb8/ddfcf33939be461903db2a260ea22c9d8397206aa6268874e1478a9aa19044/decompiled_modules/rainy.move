module 0xb8ddfcf33939be461903db2a260ea22c9d8397206aa6268874e1478a9aa19044::rainy {
    struct RAINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<RAINY>(arg0, 18355449484729930536, b"RAINY SUI", b"RAINY", x"4c65742773206d616b6520697420245241494e59206f6e2024535549f09f92a7", b"https://images.hop.ag/ipfs/QmW1t9epgxG7zjUJJqUCwFhVppndPD8fR6QuSS21uUHsvz", 0x1::string::utf8(b"https://x.com/RainyOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

