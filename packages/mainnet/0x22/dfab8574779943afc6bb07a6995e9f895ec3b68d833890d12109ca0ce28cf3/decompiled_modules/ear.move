module 0x22dfab8574779943afc6bb07a6995e9f895ec3b68d833890d12109ca0ce28cf3::ear {
    struct EAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EAR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EAR>(arg0, b"EAR", b"SUI", b"SUI ssdsdSUI ssdsdSUI ssdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWMwfuJcQkxsnxB3uZAymAhQR47PPxUgU3ACiY9gARSzb")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d93876ce6a35f538b848cded3d034e832fecd836e2a6fadfae36c18872f188b165f5e5ca336adb05e8fcba9e634492b5a4d6c35ddce1568c97d2ae84a931fa09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747654323"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

