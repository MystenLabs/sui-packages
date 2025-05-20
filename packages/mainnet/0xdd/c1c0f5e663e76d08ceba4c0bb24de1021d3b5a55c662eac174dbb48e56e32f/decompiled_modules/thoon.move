module 0xddc1c0f5e663e76d08ceba4c0bb24de1021d3b5a55c662eac174dbb48e56e32f::thoon {
    struct THOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<THOON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<THOON>(arg0, b"Thoon", b"HIPPO DEV", b"Thoon is the developer of HIPPO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUavYvuMm83FyvCXcpc1m2F1gBPJnCe4RMzRAmJ9WE26j")), b"https://www.hippocto.meme/", b"https://x.com/hippo_cto", b"DISCORD", b"https://t.me/HIPPO_SUI", 0x1::string::utf8(b"00970bc5979fe7979313611c1614cb3d0d6b084c1ce4b86c6b84fab8bcd92f6f8525d05e380a9e213d6dc7848115db69efda5e2a371502fd78389c0e4d2a55be04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759208"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

