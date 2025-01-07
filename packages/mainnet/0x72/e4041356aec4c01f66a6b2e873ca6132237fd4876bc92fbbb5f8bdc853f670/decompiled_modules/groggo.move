module 0x72e4041356aec4c01f66a6b2e873ca6132237fd4876bc92fbbb5f8bdc853f670::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GROGGO>(arg0, 5835757589836525595, b"GROGGO", b"GROGGO", b"GROGGO", b"https://images.hop.ag/ipfs/QmYAuPkXSzMJk4xzc1DmEp5fZdtp6eJR2wXEe3Eh4URrAe", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/groggosui"), arg1);
    }

    // decompiled from Move bytecode v6
}

