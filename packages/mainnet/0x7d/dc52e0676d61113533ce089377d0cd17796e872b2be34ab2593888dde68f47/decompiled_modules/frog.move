module 0x7ddc52e0676d61113533ce089377d0cd17796e872b2be34ab2593888dde68f47::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 10281139452436394327, b"HopFrogSui", b"FROG", b"Frog fierce and agile fighter, blending speed and stealth to take down enemies before they even notice. With lightning-fast reflexes and a sharp mind, he strikes swiftly and vanishes just as quickly.", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

