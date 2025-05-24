module 0x38595ce2dfe145f65f5a6ee81a08aad96b4b4c0a741b78150f295bf06e006fdc::brr {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BRR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BRR>(arg0, b"BRR", b"BullishRisker", b"Crypto bull run right now is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXMYhr9EqsmBqTFm7GwWhHsfRKMTs4fGmw6HQ6FFT7n9s")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0058d9bd727782917d9751b622610ba27854d1a5a12a7fd23f47b331eb07fdd07f32794dc83adf6ea288889b12edd2365b32e75f5ac52a9eb6205ac38eee37020ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748104017"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

