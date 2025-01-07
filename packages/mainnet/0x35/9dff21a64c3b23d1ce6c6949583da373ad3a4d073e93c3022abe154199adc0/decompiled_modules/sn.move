module 0x359dff21a64c3b23d1ce6c6949583da373ad3a4d073e93c3022abe154199adc0::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SN>(arg0, 5115696757472821023, b"SuiNova", b"SN", b"SuiNova is an innovative cryptocurrency project built on the SUI blockchain network. The project aims to provide advanced solutions in the realm of decentralized finance (DeFi) and blockchain applications. It focuses on enabling users to perform fast, secure, and cost-effective transactions while offering an exceptional user experience.", b"https://images.hop.ag/ipfs/QmR6Qs5VWqkbsboG2BnWcMrbA5XSZjyYKLumVNJrgARDx6", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

