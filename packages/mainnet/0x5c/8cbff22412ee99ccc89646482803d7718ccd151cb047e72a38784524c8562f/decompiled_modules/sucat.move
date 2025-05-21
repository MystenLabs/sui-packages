module 0x5c8cbff22412ee99ccc89646482803d7718ccd151cb047e72a38784524c8562f::sucat {
    struct SUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUCAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUCAT>(arg0, b"Sucat", b"Sui in Cat", b"Droplet cat in sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUCcKy3Lj5YrFL66dbkwJfdPGLhPcbnaTz1me5MNSxvrS")), b"app.splash.xyz", b"https://x.com/sucatsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006fa28c6f3d136072cbb787c2a2b1dd57714aaac543f1cc1272cd9bb721fef59ac903fb2bd7e9a8b42d1aea5757d7da24a8b0b1bc1e0e420ab2b32d3d07f30705d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747863982"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

