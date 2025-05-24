module 0x807fa00b59140f299cce6f30b0bac793bc9011ff3173878c26e55951ac43ad53::v {
    struct V has drop {
        dummy_field: bool,
    }

    fun init(arg0: V, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<V>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<V>(arg0, b"V", b"Vendetta", b"*-*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYeHfPydmE5e9pwyEy32gtMU9ZJKCX9fK2aPUBNzSDLQZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e58ece9f8444124a37f7852c8472777bc7c67dc382aa66972a3c056a2a28cb5618cb882091a4edf8b0ee546f5680b64f99b336986097f1d1ec2d495f8a69bf0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748080599"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

