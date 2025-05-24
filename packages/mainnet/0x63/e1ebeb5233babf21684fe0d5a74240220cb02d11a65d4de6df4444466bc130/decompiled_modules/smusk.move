module 0x63e1ebeb5233babf21684fe0d5a74240220cb02d11a65d4de6df4444466bc130::smusk {
    struct SMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SMUSK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SMUSK>(arg0, b"SMUSK", b"SUIMUSK", b"This token was created as a form of inspiration for Elon Musk and as an appreciation for the motivation and memes that he often shares on his personal X. This token is a memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRakSAGMLPjhZY9mYWFToTdWNHQwGcT4MNuw4e2BobZzC")), b"https://x.com", b"https://x.com/ElonMusk", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0036a7d42e16ce3a9ca2a4ab69c20554b93f950bb6348ba6c6edb349bc16d470b93440f661f98513f03dded81d098a53f45c5da9956e2f7bf22320ca684ca82206d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748093647"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

