module 0x51824662489e5a55a86152280dba618fb22d5cbd21e94f9243ad9fdeedb8c0c0::pumpbtc {
    struct PUMPBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PUMPBTC>(arg0, 5483942397018705689, b"TRUMP PUMPS BTC", b"PUMPBTC", b"TRUMP is PUMPING BTC TILL 100k$", b"https://images.hop.ag/ipfs/QmaSJRPGtMNyUcYXAGpDFUGDbSvquE8CfJUxsmtnwK987Q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

