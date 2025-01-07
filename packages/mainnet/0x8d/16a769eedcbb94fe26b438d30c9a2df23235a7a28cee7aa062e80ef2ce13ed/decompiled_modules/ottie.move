module 0x8d16a769eedcbb94fe26b438d30c9a2df23235a7a28cee7aa062e80ef2ce13ed::ottie {
    struct OTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OTTIE>(arg0, 8538280914355722296, b"OTTIE", b"OTTIE", x"446f6e27742061736b202c204a757374204368696c6c696e2720616e64204d6f6f6e696e272e2e2e21f09fa6a620f09f8c8a", b"https://images.hop.ag/ipfs/QmWyMpPkr3JmfeBhUKA6m8K84skYA9S4n8xYGmnwVSDA4v", 0x1::string::utf8(b"https://x.com/ottiesui"), 0x1::string::utf8(b"https://ottieonsui.xyz/"), 0x1::string::utf8(b"https://t.me/ottiesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

