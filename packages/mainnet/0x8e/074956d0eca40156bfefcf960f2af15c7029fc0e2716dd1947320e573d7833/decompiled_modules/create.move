module 0x8e074956d0eca40156bfefcf960f2af15c7029fc0e2716dd1947320e573d7833::create {
    struct CREATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CREATE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CREATE>(arg0, b"CREATE", b"Create on Splash", b"Reply to any tweet with @createonsplash +name to turn it into a coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeQ9U5NuThF7rdZKSbaGYntRYspqQJKxhQQ7sM23MAarY")), b"https://createonsplash.fun/", b"https://x.com/createonsplash", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a30db300544be2569c278d075fc2b2712e3e63383080de44efe697261b04be940a324ed8ecd635464bbcf0b8a73707ee3d5b70c5982bf7dfb0b189d2772fed07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764872"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

