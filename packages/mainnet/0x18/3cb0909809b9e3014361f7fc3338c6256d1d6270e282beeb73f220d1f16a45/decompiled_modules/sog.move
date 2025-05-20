module 0x183cb0909809b9e3014361f7fc3338c6256d1d6270e282beeb73f220d1f16a45::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SOG>(arg0, b"SOG", b"Sui Mog Coin", b"Gmog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTgXqG6MhsAPKMLPPFLkhhNLU1MNbm3SzqPYkcP6WvUn1")), b"https://x.com/Suimogcoin/", b"https://x.com/Suimogcoin", b"DISCORD", b"https://t.me/suimogcoin", 0x1::string::utf8(b"00af9d1d95e0842d043883fbb4a002971099cbb51be9cc088119bfcdc04f05f75b1eca7794cffe9a884278a8f03bc83bf351dd1e6ce66253eda836a3ba1177970cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758015"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

