module 0x31fdec0079efd8c6638f757f19e2a8a1f8cdfb1b57d45415d0a9dbecea64fabf::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<USDSUI>(arg0, 6719438318396558827, b"United State Dollar SUI", b"USDSUI", b"United State Dollar Currency on SUI network. Community Backed Stable Coin $1. Advanced Self Custodial Decentralized Manual Stabilization Protocol", b"https://images.hop.ag/ipfs/QmRekiHFLWjTDn85Ub92GW5gtGikYnqqEVPrZ9bEtMatn9", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

