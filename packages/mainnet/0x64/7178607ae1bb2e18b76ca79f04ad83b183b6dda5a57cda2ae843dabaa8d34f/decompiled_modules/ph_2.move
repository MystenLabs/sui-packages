module 0x647178607ae1bb2e18b76ca79f04ad83b183b6dda5a57cda2ae843dabaa8d34f::ph_2 {
    struct PH_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PH_2, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PH_2>(arg0, 638357838134584532, b"PHASE 2", b"PH2", x"504841534520322068617320626567756e20f09f97a3efb88f", b"https://images.hop.ag/ipfs/QmP3CTtoStxCLZS9gJ18fzMeDJQp6LxyHG5t3SxDE7zzta", 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

