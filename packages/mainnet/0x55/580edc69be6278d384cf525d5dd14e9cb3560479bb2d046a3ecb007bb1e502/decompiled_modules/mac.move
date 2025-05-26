module 0x55580edc69be6278d384cf525d5dd14e9cb3560479bb2d046a3ecb007bb1e502::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MAC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MAC>(arg0, b"MAC", b"Make a Coin", b"Make a Coin now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUbWdc3o8vFhsyBqr5qAZ5GWHJDmLv1EHQz9ScUHSwsEe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008f092a772531b9bc6da2151e4140c3f798831b713d166f753b541a69129a269bdca9041735b6f017b4d680ec1c938b81789ed6d9da586979efb2cc3e7de7ed06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748268477"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

