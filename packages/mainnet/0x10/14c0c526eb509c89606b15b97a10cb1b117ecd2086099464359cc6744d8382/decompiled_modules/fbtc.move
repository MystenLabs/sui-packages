module 0x1014c0c526eb509c89606b15b97a10cb1b117ecd2086099464359cc6744d8382::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FBTC>(arg0, 104885801478276365, b"FakeBTC", b"fBTC", b"F to the moon!", b"https://images.hop.ag/ipfs/QmNi9HdDAWc6qqKzgsg28ktK9PwwHKgdhDguLFYDRynHH2", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

