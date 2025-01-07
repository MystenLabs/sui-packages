module 0x4e43b06906d7225b1682b7a19e75d189dd0e33aa82eebb3af8cb0fd39be3d443::ottie {
    struct OTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OTTIE>(arg0, 14481627044729604054, b"OTTIE", b"OTTIE", b"Don't ask , Just Chillin' and Moonin' ...!", b"https://images.hop.ag/ipfs/QmNk2KVE36BNWqnPEqwuzb2pRxPwM65t7DXYYhZisquLtS", 0x1::string::utf8(b"https://x.com/ottiesui"), 0x1::string::utf8(b"https://ottieonsui.xyz/"), 0x1::string::utf8(b"https://t.me/ottiesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

