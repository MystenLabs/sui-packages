module 0x113816f3559f2fb49764780842c2a047f2e772acb84ff4b8d91d077dea7a1acb::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<STONKS>(arg0, 3212759134173144695, b"Stonks", b"STONKS", b"only STONKS allowed", b"https://images.hop.ag/ipfs/QmUuFo4y1ZBNPz1WTeuiZMUsdqxNuGPbexpDcMEZ8cgY1U", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/StonksOnSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

