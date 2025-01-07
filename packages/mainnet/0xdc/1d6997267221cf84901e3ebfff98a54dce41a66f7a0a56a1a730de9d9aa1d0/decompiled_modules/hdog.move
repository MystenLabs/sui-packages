module 0xdc1d6997267221cf84901e3ebfff98a54dce41a66f7a0a56a1a730de9d9aa1d0::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HDOG>(arg0, 7497439241418705064, b"Sui happy dog", b"Hdog", b"The cute dog memecoin on sui chian ,just enjoy it .", b"https://images.hop.ag/ipfs/QmNMcLpF3CWZvMnSyAj2bED5tqArp2HP4tTRSqHXQbdVGg", 0x1::string::utf8(b"https://x.com"), 0x1::string::utf8(b"https://random.dog"), 0x1::string::utf8(b"https://t.me"), arg1);
    }

    // decompiled from Move bytecode v6
}

