module 0x84dba3b253d52225fb3e70225757c688d9b3ffe5aedcfdfed69d5dc24ce07d3b::clrn {
    struct CLRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLRN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CLRN>(arg0, 2398917729020857724, b"clearn", b"cLRN", b"crypto learn and earn", b"https://images.hop.ag/ipfs/QmYZcqhKfcor1TPuyZ4zPa4Sez5DsbHBFYKCjvkiS38KCr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

