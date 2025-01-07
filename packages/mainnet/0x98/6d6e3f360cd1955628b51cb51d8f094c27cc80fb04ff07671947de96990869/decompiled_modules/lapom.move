module 0x986d6e3f360cd1955628b51cb51d8f094c27cc80fb04ff07671947de96990869::lapom {
    struct LAPOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPOM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LAPOM>(arg0, 9003428325519998845, b"LPM", b"Lapom", b"Lapom is the ticker", b"https://images.hop.ag/ipfs/QmQHjjL5TXxH2SU6Nys9KSmoVeGb45PnXwUTFF4AaV6yda", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

