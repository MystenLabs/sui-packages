module 0xfbf837e03162697f24b4a6fd5730fcf3e576f366051456e6d1b71dfab9b716bf::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAT>(arg0, b"Cat", b"SplashCat", b"The first fair launch cat from the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfHx8bvVbD8gQxXgzcy1uXQgs1WfSfsDjxPmiRyzg64NC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002758ac79ddfcb33af968b5dc8402271bb0920fbf335989a4223925d74a8eddded92630e0ab50403b38b7c4bac6de73776b657bfa03a0109ab76e875bd120fc04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747832975"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

