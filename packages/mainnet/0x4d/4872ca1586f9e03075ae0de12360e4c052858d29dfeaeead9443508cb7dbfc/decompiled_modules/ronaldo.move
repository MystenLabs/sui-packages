module 0x4d4872ca1586f9e03075ae0de12360e4c052858d29dfeaeead9443508cb7dbfc::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RONALDO>(arg0, 8905085689244198665, b"RONALDO", b"RONALDO", b"Touting instant transaction finality, rapid smart contract deployment & unmatched speed, Ronaldo is SUI and SUI is Ronaldo!", b"https://images.hop.ag/ipfs/QmTzesUrbqY6t3BAm7CS5fi4PFMRHEeh6UnWoBKCcAHCFs", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

