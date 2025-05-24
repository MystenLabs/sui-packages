module 0x5080aec48e24bd26f15097e41a885b14c68668ed3b18e7394c7bd418e392eff0::hanabi {
    struct HANABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANABI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HANABI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HANABI>(arg0, b"HANABI", b"HANABIofficial", x"4f6666696369616c206d656d65636f696e206f662048414e4142492c200a436f6d6d756e69747920737570706f7274656420746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQHRwLPKBi94gRsA3gwpx4HLFkkvgivsj83aAg8mX7EdT")), b"www.hanabi.org", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ebbd89dfeb0062fd9d921a23f4509ed41393de587f16803d16b1ab958da17f3f8f2adfdb5b37c3f917f7508f71858b3b120db0cec5c3656a08203e7e526d170dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748102279"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

