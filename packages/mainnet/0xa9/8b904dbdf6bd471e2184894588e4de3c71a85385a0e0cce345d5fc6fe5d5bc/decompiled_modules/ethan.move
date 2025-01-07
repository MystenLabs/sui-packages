module 0xa98b904dbdf6bd471e2184894588e4de3c71a85385a0e0cce345d5fc6fe5d5bc::ethan {
    struct ETHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ETHAN>(arg0, 7347989682961506020, b"AI Ethan", b"Ethan", b"The future is AI.  Online 'best friends' currently focus just upon females, but you also need an online male buddy, to chat about sports, or to just chill out and chat about anything and everything.", b"https://images.hop.ag/ipfs/QmSJRxjeiDHbmVwPk6CQzZ1MmykBHvZWNYuU2NHpEXerDi", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

