module 0xfc3d3939566693293dde13a5fdac144675af201312a73c662a6c841c01c5f583::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SDOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SDOG>(arg0, b"Sdog", b"SplashDog", b"The first fair launch dog from the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ7tPDDn2yYafe5QSH3bhvzEg9nE1rV6jAcjRzCVSzZdK")), b"WEBSITE", b"https://x.com/Splash_Dog_", b"DISCORD", b"https://t.me/SplashDog", 0x1::string::utf8(b"00dfc81fe27e3723c60c2d497209ba59283eac056798201acbf30524a80e9778a6589351c574ac48d0b6692621ec7bf2b2b590fa65527a5ba6775a5bbd3628650fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747822317"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

