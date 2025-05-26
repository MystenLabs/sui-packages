module 0x61974b6fd570e866bce0fdb60b4ee0e2b769ae17a5dddf7402741a4b611ba73c::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MG>(arg0, b"MG", b"medogob", b"a coin for testing the app", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVZDBFKGjsVgfNyRUjXRbXZ5Zr4e9xdvfN7xcjJdcWwNS")), b"https://vram.ai", b"TWITTER", b"DISCORD", b"https://t.me/vram_ai", 0x1::string::utf8(b"006e95d87a4c75a1e6659592150fb0a3e359eb4eaf75d9e248e847b08943419784926fbbfc60cf5dab14307a63b6b0589ca99a1750a5a85edc65f1127341029304d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748270051"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

