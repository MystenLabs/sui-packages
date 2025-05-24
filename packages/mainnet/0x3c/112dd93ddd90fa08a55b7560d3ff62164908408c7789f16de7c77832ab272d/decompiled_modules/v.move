module 0x3c112dd93ddd90fa08a55b7560d3ff62164908408c7789f16de7c77832ab272d::v {
    struct V has drop {
        dummy_field: bool,
    }

    fun init(arg0: V, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<V>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<V>(arg0, b"V", b"Vendetta", b"*-*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYeHfPydmE5e9pwyEy32gtMU9ZJKCX9fK2aPUBNzSDLQZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00327d0acd34277d0c9fd2a3703b0b5bf723b1768f3e96272be889e9649cb140b003610572af61e34cceb4290ca333484ec27fa7392cecd664c834791586c6810fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748080316"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

