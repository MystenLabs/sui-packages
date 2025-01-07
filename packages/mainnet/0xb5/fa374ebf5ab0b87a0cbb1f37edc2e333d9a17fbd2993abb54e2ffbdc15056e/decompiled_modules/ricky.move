module 0xb5fa374ebf5ab0b87a0cbb1f37edc2e333d9a17fbd2993abb54e2ffbdc15056e::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RICKY>(arg0, 8183319378205073657, b"Ricky The Penguin", b"Ricky", b"Hey, it's Ricky!", b"https://images.hop.ag/ipfs/QmVgs88rM3QnbTzcq8wGvqVwV1W8PKFDx7fukTdCmeXDad", 0x1::string::utf8(b"https://x.com/Rickyonsui"), 0x1::string::utf8(b"https://rickyonsui.com"), 0x1::string::utf8(b"https://t.me/Rickythepenguin"), arg1);
    }

    // decompiled from Move bytecode v6
}

