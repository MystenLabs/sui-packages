module 0x8d5b0c5ca1bb6483b5c4269772fbdb7854b66c2299d5fcc12ac3511a101132a4::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPC>(arg0, b"Spc", b"Splashcat", b"spc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbMYJhWBjxzUjToDHnp4uTFUkeY1z16xHhMMP6htMa4Ki")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0010646d96acda3d9710125c6690f607d38ef8a4d4f309c7349375aee35e8c622bbddf4eb47f4d51cf469a756746ab3f6df6caf6462620d2aa41a9b152ad09b709d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757218"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

