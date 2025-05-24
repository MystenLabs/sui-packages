module 0xbe98671e9ede70c8459465b4cbc1892a6aa5f08099cf7d312aeeb77f9ca27657::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LIQ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LIQ>(arg0, b"LIQ", b"Liqfinity DeFAI SUI", b"100% LTV Loans | No liquidation | Leveraged Liquidity | Sentinel AI | QUANT AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPyjeNrDUu3n9gZjJt9wJcro6dM77ozHCwPGNAZJppfEE")), b"Liqfinity.com", b"https://x.com/Liqfinity", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00572563ae579c38c44d16215ccb6d8bf478f73e4f4ddbaea3effe6fbe3bde0fb611d339cabbb78f30c1e61e65a3ba75adff68f71fe96626cefac5a9991e253506d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748104188"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

