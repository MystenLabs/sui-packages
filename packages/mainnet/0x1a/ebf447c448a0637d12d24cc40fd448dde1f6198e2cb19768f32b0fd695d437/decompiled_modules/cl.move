module 0x1aebf447c448a0637d12d24cc40fd448dde1f6198e2cb19768f32b0fd695d437::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CL>(arg0, b"CL", b"Crystal Lux", b"together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTVyD7NPCwTzCCjDFmepThMK9qasFWLJCYGhrNNS9yc9K")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b51ce79d79d9c84ad61c1dea1fff07a31e41295b8d272c3feeb93130bfc9b22e8156d04f065c34990f91832ccca7e62c8175af2857fdc9479d094b9c3018b30bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748275625"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

