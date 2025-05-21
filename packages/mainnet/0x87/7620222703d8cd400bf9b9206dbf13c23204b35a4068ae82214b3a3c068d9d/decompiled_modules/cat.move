module 0x877620222703d8cd400bf9b9206dbf13c23204b35a4068ae82214b3a3c068d9d::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAT>(arg0, b"CAT", b"SplashCAT", b"The first fair launch cat from the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNjpffTvDesqUxJfzxrahK1iuEKLK3iw6P764iZ7uqTsh")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0089e2b65558948c237d6a901e4a9304b4e6dc81ddc28146e40fd6cc83ee9ddf744cd02f2a3cde0f03c013c49810353f3d2cae985ee7920d03667e9d283250040dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747826433"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

